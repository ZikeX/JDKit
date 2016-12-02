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
    func configItem(_ model: ModelType)
    func bindingModel(_ model: ModelType)
    func didBindingModel(_ model: ModelType)
    func updateEnabledState(_ model:ModelType,enabled:Bool)
    func unbindingModel(_ model: ModelType?)
}
extension JDTableCell:BindingModelProtocol {
    
    func configItem(_ model: JDTableModel) {
        
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
    
    func configItem(_ model: JDCollectionModel) {
        
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
extension JDCollectionReusableView:BindingModelProtocol {
    
    func configItem(_ model: JDCollectionReusableModel) {
        
    }
    func bindingModel(_ model: JDCollectionReusableModel) {
        
    }
    func didBindingModel(_ model: JDCollectionReusableModel) {
        
    }
    func updateEnabledState(_ model:JDCollectionReusableModel,enabled:Bool) {
        
    }
    func unbindingModel(_ model: JDCollectionReusableModel?) {
        
    }
}
