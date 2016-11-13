//
//  BaseVCProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

protocol BaseVCProtocol:NavigationItemProtocol,ViewStateProtocol {
    func baseVCConfigInit()
}
extension BaseVCProtocol where Self:UIViewController {
    func baseVCConfigInit() {
        self.baseVCViewDidLoad()
        /// ZJaDe: 下面不得出现view属性
        self.automaticallyAdjustsScrollViewInsets = false
        configInitAboutNavBar()
        configInitAboutViewState()
    }
}
extension UIViewController {
    func baseVCViewDidLoad() {
        _ = self.rx.sentMessage(#selector(viewDidLoad)).subscribe { (event) in
            self.view.backgroundColor = Color.viewBackground
        }
    }
}
extension BaseViewController:BaseVCProtocol {
    
}
extension BaseTabBarController:BaseVCProtocol {
    
}
extension BaseTableViewController:BaseVCProtocol {
    
}
extension BaseCollectionViewController:BaseVCProtocol {
    
}
