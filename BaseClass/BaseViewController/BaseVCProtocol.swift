//
//  BaseVCProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol BaseVCProtocol {
    func BConfigInit()
    func BViewDidLoad()
    func BViewWillAppear()
    func BViewDidAppear()
    func BViewWillDisappear()
    func BViewDidDisappear()
}
extension BaseVCProtocol where Self:UIViewController {
    func BConfigInit() {
        self.automaticallyAdjustsScrollViewInsets = false
    }
    func BViewDidLoad() {
        view.backgroundColor = Color.viewBackground
        viewState = .viewDidLoad
    }
    func BViewWillAppear() {
        viewState = .viewWillAppear
        configInitAboutNavBar()
    }
    func BViewDidAppear() {
        viewState = .viewDidAppear
//        configInitAboutNavBar()
    }
    func BViewWillDisappear() {
        viewState = .viewWillDisappear
    }
    func BViewDidDisappear() {
        viewState = .viewDidDisappear
    }
}

extension BaseViewController:BaseVCProtocol {
    
}
extension BaseTabBarController:BaseVCProtocol {
    
}
//extension BaseTableViewController:BaseVCProtocol {
//    
//}
//extension BaseCollectionViewController:BaseVCProtocol {
//    
//}
