//
//  BindingCellProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

protocol BindingCellProtocol:class {
    associatedtype JDCellCompatibleType
    associatedtype JDUpdateEnabledStateType
    var layoutCellClosure:JDCellCompatibleType? {get set}
    var bindingCellClosure:JDCellCompatibleType? {get set}
    var updateEnabledStateClosure:JDUpdateEnabledStateType? {get set}
    
    func configLayoutCell(_ closure: JDCellCompatibleType)
    func configBindingCell(_ closure: JDCellCompatibleType)
    func configUpdateEnabledState(_ closure: JDUpdateEnabledStateType)
}
extension BindingCellProtocol {
    func configLayoutCell(_ closure: JDCellCompatibleType) {
        self.layoutCellClosure = closure
    }
    func configBindingCell(_ closure: JDCellCompatibleType) {
        self.bindingCellClosure = closure
    }
    func configUpdateEnabledState(_ closure: JDUpdateEnabledStateType) {
        self.updateEnabledStateClosure = closure
    }
}
extension JDCustomModel:BindingCellProtocol {
    typealias JDCellCompatibleType = (JDCustomCell) -> ()
    typealias JDUpdateEnabledStateType = (JDCustomCell,Bool?) -> ()
}
extension JDFormModel:BindingCellProtocol {
    typealias JDCellCompatibleType = (JDFormCell) -> ()
    typealias JDUpdateEnabledStateType = (JDFormCell,Bool?) -> ()
}
