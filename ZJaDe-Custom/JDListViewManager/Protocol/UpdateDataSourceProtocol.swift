//
//  UpdateDataSourceProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UpdateDataSourceProtocol:class,SectionedViewType {
    associatedtype SectionType:IdentifiableType
    associatedtype ModelType:IdentifiableType,Equatable,NeedUpdateProtocol
    typealias DataArrayType = [(SectionType,[ModelType])]
    typealias SectionModelType = AnimatableSectionModel<SectionType,ModelType>
    
    typealias UpdateDataClosureType = (DataArrayType) -> DataArrayType?
    var dataArray:[(SectionType,[ModelType])] {get set}
    var sectionModelsChanged:PublishSubject<[SectionModelType]> {get set}
    @discardableResult
    func updateDataSource(_ closure:@escaping UpdateDataClosureType)
    /// ZJaDe: 初始化dataSource
    func configDataSource()
    /// ZJaDe: 计算tableView的cell高度
    func calculateItemHeight()
}
extension UpdateDataSourceProtocol {
    @discardableResult
    final func updateDataSource(_ closure:@escaping UpdateDataClosureType) {
        DispatchQueue.global().async {
            if let newData = closure(self.dataArray) {
                self.dataArray = newData
                var sectionModels = [AnimatableSectionModel<SectionType,ModelType>]()
                for (section,models) in newData {
                    models.forEach({ (model) in
                        if let model = model as? JDTableViewModel {
                            model.invalidateCellHeight()
                        }
                    })
                    sectionModels.append(AnimatableSectionModel(model: section, items: models))
                }
                DispatchQueue.main.async {
                    self.sectionModelsChanged.onNext(sectionModels)
                    self.calculateItemHeight()
                    self.updateItemsAnimated(dataArray: newData)
                }
            }
        }
    }
    func updateItemsAnimated(dataArray:[(SectionType,[ModelType])]) {
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
        self.performBatchUpdates(result, animationConfiguration: AnimationConfiguration(reloadAnimation:.automatic))
    }
    
    func calculateItemHeight() {
        
    }
}
private var JDTableViewRunloopObserverKey: UInt8 = 0
extension JDTableView:UpdateDataSourceProtocol {
    var runloopObserver:CFRunLoopObserver? {
        get {
            return objc_getAssociatedObject(self, &JDTableViewRunloopObserverKey) as! CFRunLoopObserver?
        }
        set {
            objc_setAssociatedObject(self, &JDTableViewRunloopObserverKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    typealias SectionType = JDTableViewSection
    typealias ModelType = JDTableViewModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource, tableView, indexPath, model) in
            let cell =  model.createCellWithTableView(tableView, indexPath: indexPath)!
            cell.height = model.calculateCellHeight(tableView)
            return cell
        }
        self.sectionModelsChanged.asObservable().bindTo(self.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
    }
    func calculateItemHeight() {
        var indexPaths = [IndexPath]()
        for (i,(_,models)) in self.dataArray.enumerated() {
            for (j,_) in models.enumerated() {
                    indexPaths.append(IndexPath(item: j, section: i))
            }
        }
        jd.removeRunLoopObserver(observer: self.runloopObserver)
        self.runloopObserver = jd.runWhenBeforeWaiting { () -> (Bool) in
            let indexPath = indexPaths.first
            if indexPath != nil {
                indexPaths.removeFirst()
                self.perform(#selector(self.calculateCellHeight), on: Thread.main, with: indexPath!, waitUntilDone: false,modes:[RunLoopMode.defaultRunLoopMode.rawValue])
                return false
            }else {
                return true
            }
        }
    }
    func calculateCellHeight(indexPath:IndexPath) {
        if let model = (try? self.rxDataSource.model(at: indexPath)) as? JDTableViewModel {
            _ = model.calculateCellHeight(self)
        }
    }

}
extension JDCollectionView:UpdateDataSourceProtocol {

    typealias SectionType = JDCollectionViewSection
    typealias ModelType = JDCollectionViewModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource,colectionView,indexPath,model) in
            let cell = colectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath) as! JDCollectionViewCell
            cell.cellDidLoad(model)
            return cell
        }
        self.sectionModelsChanged.asObservable().bindTo(self.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
    }
}
