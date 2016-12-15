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

protocol ObjDisposeBagProtocol:AssociatedObjectProtocol {
    var disposeBag:DisposeBag {get set}
}

private var jdDisposeBagKey:UInt8 = 0
extension ObjDisposeBagProtocol {
    var disposeBag:DisposeBag {
        get {
            return associatedObject(&jdDisposeBagKey, createIfNeed: { () -> DisposeBag in
                return DisposeBag()
            })
        }
        set {
            setAssociatedObject(&jdDisposeBagKey, newValue)
        }
    }
}

extension UIView:ObjDisposeBagProtocol {}
extension UIViewController:ObjDisposeBagProtocol {}
