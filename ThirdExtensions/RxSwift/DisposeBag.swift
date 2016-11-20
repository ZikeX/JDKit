//
//  Dis.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/20.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ObjDisposeBagProtocol:class {
    var disposeBag:DisposeBag {get set}
}

private var jdDisposeBagKey:UInt8 = 0
extension ObjDisposeBagProtocol {
    var disposeBag:DisposeBag {
        get {
            var bag:DisposeBag
            if let existing = objc_getAssociatedObject(self, &jdDisposeBagKey) as? DisposeBag {
                bag = existing
            }else {
                bag = DisposeBag()
                self.disposeBag = bag
            }
            return bag
        }
        set {
            objc_setAssociatedObject(self, &jdDisposeBagKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIView:ObjDisposeBagProtocol {}
extension UIViewController:ObjDisposeBagProtocol {}
