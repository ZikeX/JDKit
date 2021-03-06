//
//  Swizzle.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
protocol SelectorProtocol {
    var selectorValue:Selector {get}
}

extension Selector:SelectorProtocol {
    var selectorValue: Selector {
        return self
    }
}
extension String:SelectorProtocol {
    var selectorValue: Selector {
        return NSSelectorFromString(self)
    }
}
extension NSObject {
    @discardableResult
    class func swizzle<T:SelectorProtocol,U:SelectorProtocol>(original:T,swizzled:U) -> Bool {
        let originalSel = original.selectorValue
        let swizzledSel = swizzled.selectorValue
        let originalMethod = class_getInstanceMethod(self, originalSel)
        if originalMethod == nil {
            return false
        }
        let swizzledMethod = class_getInstanceMethod(self, swizzledSel)
        if swizzledMethod == nil {
            return false
        }
        
        class_addMethod(self,originalSel,class_getMethodImplementation(self, originalSel),method_getTypeEncoding(originalMethod))
        class_addMethod(self,swizzledSel,class_getMethodImplementation(self, swizzledSel),method_getTypeEncoding(swizzledMethod))
        
        method_exchangeImplementations(class_getInstanceMethod(self, originalSel), class_getInstanceMethod(self, swizzledSel));
        return true
    }
}

