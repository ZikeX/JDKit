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
    func configInitAboutViewState()
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
extension UIViewController {
    func configInitAboutViewState() {
        _ = self.rx.sentMessage(#selector(viewDidLoad)).subscribe { (event) in
            self.viewState = .viewDidLoad
        }
        _ = self.rx.sentMessage(#selector(viewWillAppear)).subscribe { (event) in
            self.viewState = .viewWillAppear
        }
        _ = self.rx.sentMessage(#selector(viewDidAppear)).subscribe { (event) in
            self.viewState = .viewDidAppear
        }
        _ = self.rx.sentMessage(#selector(viewWillDisappear)).subscribe { (event) in
            self.viewState = .viewWillDisappear
        }
        _ = self.rx.sentMessage(#selector(viewDidDisappear)).subscribe { (event) in
            self.viewState = .viewDidDisappear
        }
    }
}
