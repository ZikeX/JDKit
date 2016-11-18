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
    var layoutCellClosure:JDCellCompatibleType? {get set}
    var bindingCellClosure:JDCellCompatibleType? {get set}
    func configLayoutCell(_ closure: JDCellCompatibleType)
    func configBindingCell(_ closure: JDCellCompatibleType)
}
extension BindingCellProtocol {
    func configLayoutCell(_ closure: JDCellCompatibleType) {
        self.layoutCellClosure = closure
    }
    func configBindingCell(_ closure: JDCellCompatibleType) {
        self.bindingCellClosure = closure
    }
}
extension JDFormModel:BindingCellProtocol {
    typealias JDCellCompatibleType = (JDFormCell) -> ()
}
