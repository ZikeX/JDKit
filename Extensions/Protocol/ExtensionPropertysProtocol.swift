//
//  ExtensionPropertysProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/16.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

protocol ExtensionPropertysProtocol:AssociatedObjectProtocol {
    typealias DictType = [String:Any]
    var extenPropertys:DictType {get set}
}
private var extensionPropertysKey: UInt8 = 0
extension ExtensionPropertysProtocol where Self:AnyObject {
    
    var extenPropertys:DictType {
        get {
            return associatedObject(&extensionPropertysKey, createIfNeed: { () -> DictType in
                DictType.init()
            })
        }
        set {
            setAssociatedObject(&extensionPropertysKey, newValue)
        }
    }
}
