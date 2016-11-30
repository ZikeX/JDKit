//
//  BindingModelProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
protocol BindingModelProtocol {
    associatedtype ModelType:JDListModel
    func configCell(_ model: ModelType)
    func bindingModel(_ model: ModelType)
    func didBindingModel(_ model: ModelType)
    func updateEnabledState(_ model:ModelType,enabled:Bool)
    func unbindingModel(_ model: ModelType?)
}
extension JDTableCell:BindingModelProtocol {
    
    func configCell(_ model: JDTableModel) {
        
    }
    func bindingModel(_ model: JDTableModel) {
        
    }
    func didBindingModel(_ model: JDTableModel) {
        
    }
    func updateEnabledState(_ model:JDTableModel,enabled:Bool) {
        
    }
    func unbindingModel(_ model: JDTableModel?) {
        
    }
}
extension JDCollectionCell:BindingModelProtocol {
    
    func configCell(_ model: JDCollectionModel) {
        
    }
    func bindingModel(_ model: JDCollectionModel) {
        
    }
    func didBindingModel(_ model: JDCollectionModel) {
        
    }
    func updateEnabledState(_ model:JDCollectionModel,enabled:Bool) {
        
    }
    func unbindingModel(_ model: JDCollectionModel?) {
        
    }
}
//// MARK: - thunk
//struct BindingModelProtocolThunk<T:JDListModel>:BindingModelProtocol {
//
//    private let _configCell : (T) -> Void
//    private let _bindingModel : (T) -> Void
//    private let _didBindingModel : (T) -> Void
//    private let _unbindingModel : (T?) -> Void
//    
//    init<P : BindingModelProtocol>(_ dep : P) where P.ModelType == T {
//        _configCell = dep.configCell
//        _bindingModel = dep.bindingModel
//        _didBindingModel = dep.didBindingModel
//        _unbindingModel = dep.unbindingModel
//    }
//    
//    func didBindingModel(_ model: T) {
//        _didBindingModel(model)
//    }
//    func configCell(_ model: T) {
//        _configCell(model)
//    }
//    func bindingModel(_ model: T) {
//        _bindingModel(model)
//    }
//    func unbindingModel(_ model: T?) {
//        _unbindingModel(model)
//    }
//}
