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
extension BaseViewController:ViewStateProtocol {

}
extension BaseTabBarController:ViewStateProtocol {
    
}
private var jd_viewStateKey: UInt8 = 0
extension UIViewController {
    var viewState: RootViewState {
        get {
            return associatedObject(&jd_viewStateKey, createIfNeed: {.viewNoLoad})
        }
        set {
            setAssociatedObject(&jd_viewStateKey, newValue)
        }
    }
}
