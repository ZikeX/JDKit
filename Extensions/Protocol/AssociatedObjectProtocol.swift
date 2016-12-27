//
//  AssociatedObjectProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

protocol AssociatedObjectProtocol:class {
    // MARK: - get
    func associatedObject<V>(_ key:inout UInt8) -> V?
    func associatedObject<V>(_ key:inout UInt8, createIfNeed closure:(()->V)) -> V
    // MARK: - set
    func setAssociatedObject<V>(_ key:inout UInt8, _ newValue:V)
    func setAssociatedWeakObject<V>(_ key:inout UInt8, _ newValue:V)
}
extension AssociatedObjectProtocol {
    
    // MARK: - get
    func associatedObject<V>(_ key:inout UInt8) -> V? {
        return objc_getAssociatedObject(self, &key) as? V
    }
    func associatedObject<V>(_ key:inout UInt8, createIfNeed closure:(()->V)) -> V {
        var value:V
        if let existing:V = associatedObject(&key) {
            value = existing
        }else {
            value = closure()
            self.setAssociatedObject(&key, value)
        }
        return value
    }
    // MARK: - set
    func setAssociatedObject<V>(_ key:inout UInt8, _ newValue:V) {
        objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func setAssociatedWeakObject<V>(_ key:inout UInt8, _ newValue:V) {
        objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_ASSIGN)
    }
}
extension NSObject:AssociatedObjectProtocol{}


