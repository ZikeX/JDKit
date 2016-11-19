//
//  Aspects.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import Aspects

extension NSObject {
    typealias AOPClosure = @convention(block) (AspectInfo) -> ()
    @discardableResult
    static func aop_hook(_ selector: Selector!, options: AspectOptions = [], closure: AOPClosure) -> AspectToken {
        let warppedObject:AnyObject = unsafeBitCast(closure, to: AnyObject.self)
        let aspectToken = try! self.aspect_hook(selector, with: options, usingBlock: warppedObject)
        return aspectToken
    }
    @discardableResult
    func aop_hook(_ selector: Selector!, options: AspectOptions = [], closure: AOPClosure) -> AspectToken {
        let warppedObject:AnyObject = unsafeBitCast(closure, to: AnyObject.self)
        let aspectToken = try! self.aspect_hook(selector, with: options, usingBlock: warppedObject)
        return aspectToken
    }
}
class AOP {
    static func register() {
        
    }
}
