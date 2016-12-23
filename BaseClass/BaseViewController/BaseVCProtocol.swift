//
//  BaseVCProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol BaseVCProtocol:class {
    func jdConfigInit()
    func jdViewDidLoad()
    func jdViewWillAppear()
    func jdViewDidAppear()
    func jdViewWillDisappear()
    func jdViewDidDisappear()
    var isFirstIn:Bool {get set}
    func viewDidFirstAppear()
}
extension BaseVCProtocol where Self:UIViewController {
    func jdConfigInit() {
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func jdViewDidLoad() {
        view.backgroundColor = Color.viewBackground
        viewState = .viewDidLoad
    }
    func jdViewWillAppear() {
        viewState = .viewWillAppear
        configInitAboutNavBar()
    }
    func jdViewDidAppear() {
        viewState = .viewDidAppear
//        configInitAboutNavBar()
        if isFirstIn {
            isFirstIn = false
            viewDidFirstAppear()
        }
    }

    func jdViewWillDisappear() {
        viewState = .viewWillDisappear
    }
    func jdViewDidDisappear() {
        viewState = .viewDidDisappear
    }
}

extension BaseViewController:BaseVCProtocol {
    func viewDidFirstAppear() {
        
    }
}
extension BaseTabBarController:BaseVCProtocol {
    func viewDidFirstAppear() {
        
    }
}
