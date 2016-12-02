//
//  UpdateDataSourceProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UpdateDataSourceProtocol:class {
    associatedtype SectionType:IdentifiableType
    associatedtype ModelType:ListModelStateProtocol,IdentifiableType,Equatable,NeedUpdateProtocol
    typealias DataArrayType = [(SectionType,[ModelType])]
    typealias SectionModelType = AnimatableSectionModel<SectionType,ModelType>
    
    var listView:SectionedViewType? {get}
    typealias UpdateDataClosureType = (DataArrayType) -> DataArrayType?
    var dataArray:[(SectionType,[ModelType])] {get set}
    var sectionModelsChanged:PublishSubject<[SectionModelType]> {get set}
    @discardableResult
    func updateDataSource(_ closure:@escaping UpdateDataClosureType)
    /// ZJaDe: 初始化dataSource 和 delegate
    func configDataSource()
    func configDelegate()
    /// ZJaDe: 计算tableView的cell高度
    func dataArrayDidSet()
}
extension UpdateDataSourceProtocol where Self:JDListViewModel {
    @discardableResult
    final func updateDataSource(_ closure:@escaping UpdateDataClosureType) {
        Async.background { () -> [AnimatableSectionModel<SectionType,ModelType>]? in
            if let newData = closure(self.dataArray) {
                self.dataArray = newData
                self.dataArrayDidSet()
                self.updateSelectIndexPath()
                var sectionModels = [AnimatableSectionModel<SectionType,ModelType>]()
                for (section,models) in newData {
                    let showModels = models.filter({ (model) -> Bool in
                        return !model.isHidden
                    })
                    sectionModels.append(AnimatableSectionModel(model: section, items: showModels))
                }
                return sectionModels
            }else {
                return nil
            }
            }.main { (sectionModels) -> () in
                if let sectionModels = sectionModels {
                    self.sectionModelsChanged.onNext(sectionModels)
                    self.updateItemsAnimated()
                }
                if let scrollView = self.listView as? UIScrollView {
                    scrollView.reloadEmptyDataSet(.loaded)
                }
        }
    }
    func updateItemsAnimated() {
        var updateItems = [ItemPath]()
        for (i,(_,models)) in dataArray.enumerated() {
            for (j,model) in models.enumerated() {
                if model.needUpdate {
                    model.needUpdate = false
                    updateItems.append(ItemPath(sectionIndex: i, itemIndex: j))
                }
            }
        }
        let result = Changeset<SectionModelType>(updatedItems: updateItems)
        self.listView?.performBatchUpdates(result, animationConfiguration: AnimationConfiguration(reloadAnimation:.automatic))
        if updateItems.count > 0 {
        }
    }
    // MARK: -
    func dataArrayDidSet() {
        
    }
    func updateSelectIndexPath() {
        for (i,(_,models)) in dataArray.enumerated() {
            for (j,model) in models.enumerated() {
                let indexPath = IndexPath(item: j, section: i)
                if model.isSelected {
                    self.selectedIndexPaths.append(indexPath)
                }else if let index = self.selectedIndexPaths.index(of: indexPath){
                    self.selectedIndexPaths.remove(at: index)
                }
            }
        }
    }
}
private var JDTableViewRunloopTimerKey: UInt8 = 0
extension JDTableViewModel:UpdateDataSourceProtocol {
    var listView: SectionedViewType? {
        return self.tableView
    }
    var timer:Timer? {
        get {
            return objc_getAssociatedObject(self, &JDTableViewRunloopTimerKey) as! Timer?
        }
        set {
            objc_setAssociatedObject(self, &JDTableViewRunloopTimerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    typealias SectionType = JDTableSection
    typealias ModelType = JDTableModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource, tableView, indexPath, model) in
            let cell = model.createCellWithTableView(tableView, indexPath: indexPath)!
            _ = model.calculateCellHeight(tableView,wait: true)
            return cell
        }
        self.tableView.dataSource = nil
        self.tableView.delegate = nil
        self.sectionModelsChanged.asObservable().bindTo(self.tableView.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
    }
    func configDelegate() {
        self.tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    // MARK: - 
    func dataArrayDidSet() {
        Async.main {
            self.calculateItemsHeight()
        }
    }
    func calculateItemsHeight() {
        let modelTable = NSHashTable<JDTableModel>.weakObjects()
        self.dataArray.forEach { (section,models) in
            models.forEach({ (model) in
                modelTable.add(model)
            })
        }
        self.timer?.invalidate()
        self.timer = Timer.scheduleTimer(0.01) {[weak self] (timer) in
            if let model = modelTable.anyObject,self != nil {
                modelTable.remove(model)
                _ = model.calculateCellHeight(self!.tableView,wait: false)
            }else {
                timer?.invalidate()
            }
        }
    }
}
extension JDCollectionViewModel:UpdateDataSourceProtocol {
    var listView: SectionedViewType? {
        return self.collectionView
    }
    typealias SectionType = JDCollectionSection
    typealias ModelType = JDCollectionModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource,collectionView,indexPath,model) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath) as! JDCollectionCell
            return cell
        }
        rxDataSource.supplementaryViewFactory = {[unowned self] (dataSource,collectionView,kind,indexPath) in
            if kind == UICollectionElementKindSectionHeader {
                return self.supplementaryHeaderView(collectionView: collectionView as! JDCollectionView, indexPath: indexPath)
            }else if kind == UICollectionElementKindSectionFooter {
                return self.supplementaryFooterView(collectionView: collectionView as! JDCollectionView, indexPath: indexPath)
            }else {
                fatalError("kind错误-->\(kind)")
            }
        }
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        self.sectionModelsChanged.asObservable().bindTo(self.collectionView.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
    }
    func configDelegate() {
        self.collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
}
