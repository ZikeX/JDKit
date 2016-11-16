//
//  ThenProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/16.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

protocol ThenProtocol {
    
}
extension ThenProtocol where Self:Any {
    func then_Any(_ closure: (inout Self) -> ()) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
extension ThenProtocol where Self:AnyObject {
    @discardableResult
    func then(_ closure: (Self) -> ()) -> Self {
        closure(self)
        return self
    }
}
extension NSObject:ThenProtocol {
    
}
