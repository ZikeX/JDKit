//
//  CatchParamsProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

typealias CatchParamsClosure = () -> [String:Any]
protocol CatchParamsProtocol {
    var key:String {get}
    func catchParams() -> [String:Any]
}
extension CatchParamsProtocol where Self:TableModel {
    
}
// MARK: -
typealias  CheckParamsClosure = () -> Bool
protocol CheckParamsProtocol {
    func checkParams() -> Bool
}
// MARK: - 
private var CatchParamsClosureKey:UInt8 = 0
private var CheckParamsClosureKey:UInt8 = 0
extension TableModel {
    fileprivate(set) var catchParamsClosure:CatchParamsClosure? {
        get {
            return associatedObject(&CatchParamsClosureKey)
        }
        set {
            setAssociatedObject(&CatchParamsClosureKey, newValue)
        }
    }
    fileprivate(set) var checkParamsClosure:CheckParamsClosure? {
        get {
            return associatedObject(&CheckParamsClosureKey)
        }
        set {
            setAssociatedObject(&CheckParamsClosureKey, newValue)
        }
    }
    /// ZJaDe:
    func configCatchParams(_ closure:@escaping CatchParamsClosure) {
        self.catchParamsClosure = closure
    }
    func configCheckParams(_ closure:@escaping CheckParamsClosure) {
        self.checkParamsClosure = closure
    }
    
}



