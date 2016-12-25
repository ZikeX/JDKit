//
//  BindingModelProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
protocol BindingModelProtocol {
    associatedtype ModelType:ListModel
    func configItem(_ model: ModelType)
    func bindingModel(_ model: ModelType)
    func didBindingModel(_ model: ModelType)
    func updateEnabledState(_ model:ModelType,enabled:Bool)
    func unbindingModel(_ model: ModelType?)
}
extension TableCell:BindingModelProtocol {
    
    func configItem(_ model: TableModel) {
        
    }
    func bindingModel(_ model: TableModel) {
        
    }
    func didBindingModel(_ model: TableModel) {
        
    }
    func updateEnabledState(_ model:TableModel,enabled:Bool) {
        
    }
    func unbindingModel(_ model: TableModel?) {
        
    }
}
extension CollectionCell:BindingModelProtocol {
    
    func configItem(_ model: CollectionModel) {
        
    }
    func bindingModel(_ model: CollectionModel) {
        
    }
    func didBindingModel(_ model: CollectionModel) {
        
    }
    func updateEnabledState(_ model:CollectionModel,enabled:Bool) {
        
    }
    func unbindingModel(_ model: CollectionModel?) {
        
    }
}
extension CollectionReusableView:BindingModelProtocol {
    
    func configItem(_ model: CollectionReusableModel) {
        
    }
    func bindingModel(_ model: CollectionReusableModel) {
        
    }
    func didBindingModel(_ model: CollectionReusableModel) {
        
    }
    func updateEnabledState(_ model:CollectionReusableModel,enabled:Bool) {
        
    }
    func unbindingModel(_ model: CollectionReusableModel?) {
        
    }
}
