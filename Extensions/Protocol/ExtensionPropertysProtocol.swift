//
//  ExtensionPropertysProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/16.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

protocol ExtensionPropertysProtocol:class {
    typealias DictType = [String:Any]
    var extenPropertys:DictType {get set}
}
private var ExtensionPropertysKey: UInt8 = 0
extension ExtensionPropertysProtocol where Self:AnyObject {
    
    var extenPropertys:DictType {
        get {
            if let dict = objc_getAssociatedObject(self, &ExtensionPropertysKey) as? DictType {
                return dict
            }else {
                let dict = DictType.init()
                self.extenPropertys = dict
                return dict
            }
        }
        set {
            objc_setAssociatedObject(self, &ExtensionPropertysKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
