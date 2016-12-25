//
//  CatchParamsProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

protocol CatchParamsProtocol {
    var key:String {get}
    func catchParams() -> [String:Any]
    
    typealias CatchParamsClosure = () -> [String:Any]
    func configCatchParams(_ closure:@escaping CatchParamsClosure)
}
extension CatchParamsProtocol where Self:TableModel {
    func configCatchParams(_ closure:@escaping CatchParamsClosure) {
        self.catchParamsClosure = closure
    }
}
// MARK: - 
protocol CheckParamsProtocol {
    func checkParams() -> Bool
    
    typealias  CheckParamsClosure = () -> Bool
    func configCheckParams(_ closure:@escaping CheckParamsClosure)
}
extension CheckParamsProtocol where Self:TableModel {
    func configCheckParams(_ closure:@escaping CheckParamsClosure) {
        self.checkParamsClosure = closure
    }
}




