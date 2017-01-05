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
    
    func updateDataSource(_ closure:@escaping UpdateDataClosureType)
    /// ZJaDe: 初始化dataSource 和 delegate
    func configDataSource()
    func configDelegate()
    /// ZJaDe: 计算tableView的cell高度
    func dataArrayDidSet()
}
extension UpdateDataSourceProtocol where Self:ListViewModel {
    final func updateDataSource(_ closure:@escaping UpdateDataClosureType) {
        Async.background { () -> [AnimatableSectionModel<SectionType,ModelType>]? in
            if let newData = closure(self.dataArray) {
                self.dataArray = newData
                self.dataArrayDidSet()
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
            /// ZJaDe: 这里加一个Async.main，主要是因为上面更新数据源的时候可能有延时
            Async.main {
                if let scrollView = self.listView as? UIScrollView {
                    scrollView.reloadEmptyDataSet(.loaded)
                }
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
        Timer.performAfter(0.01) {
            if updateItems.count > 0 {
                let result = Changeset<SectionModelType>(updatedItems: updateItems)
                self.listView?.performBatchUpdates(result, animationConfiguration: AnimationConfiguration(reloadAnimation:.automatic))
            }
        }
    }
    // MARK: -
    func dataArrayDidSet() {
        
    }
}
private var tableViewRunloopTimerKey: UInt8 = 0
extension TableViewModel:UpdateDataSourceProtocol {
    var listView: SectionedViewType? {
        return self.tableView
    }
    var timer:Timer? {
        get {
            return associatedObject(&tableViewRunloopTimerKey)
        }
        set {
            setAssociatedObject(&tableViewRunloopTimerKey, newValue)
        }
    }
    
    typealias SectionType = TableSection
    typealias ModelType = TableModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource, tableView, indexPath, model) in
            let cell = model.createCellWithTableView(tableView, indexPath: indexPath) as! TableCell
            cell.itemDidLoad(model)
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
        let modelTable = NSHashTable<TableModel>.weakObjects()
        self.dataArray.forEach { (section,models) in
            models.forEach({ (model) in
                modelTable.add(model)
            })
        }
        self.timer?.invalidate()
        self.timer = Timer.scheduleTimer(0) {[weak self] (timer) in
            if let model = modelTable.anyObject,self != nil {
                modelTable.remove(model)
                _ = model.calculateCellHeight(self!.tableView,wait: false)
            }else {
                timer?.invalidate()
            }
        }
    }
    // MARK: - 更新数据
    func updateDateScouceAppend(_ modelArray:[TableModel]) {
        self.updateDataSource { (oldData) -> [(TableSection, [TableModel])]? in
            var newData = oldData
            let section:TableSection
            let models:[TableModel]
            if let last = newData.popLast() {
                section = last.0
                models = last.1 + modelArray
            }else {
                section = TableSection()
                models = modelArray
            }
            newData.append((section,models))
            return newData
        }
    }
    // MARK:
    func updateDateScouceDeleteIndexPaths(_ indexPaths:[IndexPath]) {
        let models = indexPaths.map{self.getModel($0)}.filter{$0 != nil} as! [TableModel]
        updateDateScouceDeleteModels(models)
    }
    func updateDateScouceDeleteModels(_ models:[TableModel]) {
        self.updateDataSource { (oldData) -> [(TableSection, [TableModel])]? in
            var newData = oldData
            self.deleteModel(&newData, models)
            return newData
        }
    }
    private func deleteModel(_ dataArray:inout [(TableSection, [TableModel])], _ models:[TableModel]) {
        var newDataArray = [(TableSection, [TableModel])]()
        
        for sectionModel in dataArray {
            var newModels = [TableModel]()
            for model in sectionModel.1 {
                if !models.contains(model) {
                    newModels.append(model)
                }
            }
            newDataArray.append((sectionModel.0,newModels))
        }
        dataArray = newDataArray
    }
}
extension CollectionViewModel:UpdateDataSourceProtocol {
    var listView: SectionedViewType? {
        return self.collectionView
    }
    typealias SectionType = CollectionSection
    typealias ModelType = CollectionModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource,collectionView,indexPath,model) in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath) as! CollectionCell
            cell.itemDidLoad(model)
            return cell
        }
        rxDataSource.supplementaryViewFactory = {[unowned self] (dataSource,collectionView,kind,indexPath) in
            let model = self.getReusableModel(indexPath, kind: kind)!
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: model.reuseIdentifier, for: indexPath)
            return reusableView
        }
        self.collectionView.delegate = nil
        self.collectionView.dataSource = nil
        self.sectionModelsChanged.asObservable().bindTo(self.collectionView.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
    }
    func configDelegate() {
        self.collectionView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
}
