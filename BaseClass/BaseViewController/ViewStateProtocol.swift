//
//  ViewStateProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum RootViewState {
    case viewNoLoad
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
    
    var isLoad:Bool {
        switch self {
        case .viewNoLoad:
            return false
        default:
            return true
        }
    }
}

protocol ViewStateProtocol {
    var viewState:RootViewState {get set}
}
private var jd_viewStateKey: UInt8 = 0
extension UIViewController:ViewStateProtocol {
    var viewState: RootViewState {
        get {
            let viewState = objc_getAssociatedObject(self, &jd_viewStateKey) as? RootViewState
            return viewState ?? .viewNoLoad
        }
        set {
            objc_setAssociatedObject(self, &jd_viewStateKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}
