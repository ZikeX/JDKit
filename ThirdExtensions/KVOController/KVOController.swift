//
//  KVOController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import KVOController

extension NSObject {
    var kvo:FBKVOController {
        return self.kvoController
    }
    var weakKvo:FBKVOController {
        return self.kvoControllerNonRetaining
    }
}
extension FBKVOController {
    typealias ClosureType = (Any?, Any, [String : Any]) -> Swift.Void
    func observe<E>(_ type: E.Type,_ object:Any?, keyPath: String, options: NSKeyValueObservingOptions = [.new, .initial], block: @escaping ()->()) {
        self.observe(object, keyPath: keyPath, options: options) { (observe, object, change) in
            
        }
    }
}
