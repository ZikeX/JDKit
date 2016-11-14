//
//  BindingModelProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
protocol BindingModelProtocol {
    associatedtype ModelType:JDModel
    func configCell(_ model: ModelType)
    func bindingModel(_ model: ModelType)
    func didBindingModel(_ model: ModelType)
    func unbindingModel(_ model: ModelType)
}
extension JDTableViewCell:BindingModelProtocol {
    
    func configCell(_ model: JDTableViewModel) {
        
    }
    func bindingModel(_ model: JDTableViewModel) {
        
    }
    func didBindingModel(_ model: JDTableViewModel) {
        
    }
    func unbindingModel(_ model: JDTableViewModel) {
        
    }
}
// MARK: - thunk
struct BindingModelProtocolThunk<T:JDModel>:BindingModelProtocol {

    private let _configCell : (T) -> Void
    private let _bindingModel : (T) -> Void
    private let _didBindingModel : (T) -> Void
    private let _unbindingModel : (T) -> Void
    
    init<P : BindingModelProtocol>(_ dep : P) where P.ModelType == T {
        _configCell = dep.configCell
        _bindingModel = dep.bindingModel
        _didBindingModel = dep.didBindingModel
        _unbindingModel = dep.unbindingModel
    }
    
    func didBindingModel(_ model: T) {
        _didBindingModel(model)
    }
    func configCell(_ model: T) {
        _configCell(model)
    }
    func bindingModel(_ model: T) {
        _bindingModel(model)
    }
    func unbindingModel(_ model: T) {
        _unbindingModel(model)
    }
}
