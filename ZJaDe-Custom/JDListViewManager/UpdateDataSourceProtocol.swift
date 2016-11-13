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

protocol UpdateDataSourceProtocol:class {
    associatedtype SectionType:IdentifiableType
    associatedtype ModelType:IdentifiableType,Equatable
    typealias DataArrayType = [(SectionType,[ModelType])]
    typealias SectionModelType = AnimatableSectionModel<SectionType,ModelType>
    
    typealias UpdateDataClosureType = (DataArrayType) -> DataArrayType?
    var dataArray:[(SectionType,[ModelType])] {get set}
    var sectionModels:Variable<[SectionModelType]> {get set}
    @discardableResult
    func updateDataSource(_ closure:@escaping UpdateDataClosureType)
    func configDataSource()
}
extension UpdateDataSourceProtocol {
    @discardableResult
    final func updateDataSource(_ closure:@escaping UpdateDataClosureType) {
        DispatchQueue.global().async {
            if let newData = closure(self.dataArray) {
                self.dataArray = newData
                var sectionModels = [AnimatableSectionModel<SectionType,ModelType>]()
                for (section,models) in newData {
                    sectionModels.append(AnimatableSectionModel(model: section, items: models))
                }
                DispatchQueue.main.async {
                    self.sectionModels.value = sectionModels
                }
            }
        }
    }
}
extension JDTableView:UpdateDataSourceProtocol {
    typealias SectionType = JDTableViewSection
    typealias ModelType = JDTableViewModel
    func configDataSource() {
        rxDataSource.configureCell = {(dataSource, tableView, indexPath, model) in
            let cell =  model.createCellWithTableView(tableView, indexPath: indexPath)!
            _ = model.calculateCellHeight(tableView)
            return cell
        }
        self.sectionModels.asObservable().bindTo(self.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
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
        self.sectionModels.asObservable().bindTo(self.rx.items(dataSource: rxDataSource)).addDisposableTo(disposeBag)
    }
}
