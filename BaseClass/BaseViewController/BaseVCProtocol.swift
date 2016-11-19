//
//  BaseVCProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol BaseVCProtocol {
    func baseVCConfigInit()
    
}
extension BaseVCProtocol where Self:UIViewController {
    func baseVCConfigInit() {
        self.automaticallyAdjustsScrollViewInsets = false
        self.baseVCViewDidLoad()
    }
}
extension UIViewController {
    func baseVCViewDidLoad() {
        self.aop_hook(#selector(viewDidLoad)) { (info) in
            if let viewCon = info.instance() as? UIViewController {
               viewCon.view.backgroundColor = Color.viewBackground
                viewCon.viewState = .viewDidLoad
            }
        }
        self.aop_hook(#selector(viewWillAppear)) {(info) in
            let viewCon = info.instance() as! UIViewController
            viewCon.viewState = .viewWillAppear
            viewCon.configInitAboutNavBar()
        }
        self.aop_hook(#selector(viewDidAppear)) {(info) in
            let viewCon = info.instance() as! UIViewController
            viewCon.viewState = .viewDidAppear
            viewCon.configInitAboutNavBar()
        }
        self.aop_hook(#selector(viewWillDisappear)) {(info) in
            let viewCon = info.instance() as! UIViewController
            viewCon.viewState = .viewWillDisappear
        }
        self.aop_hook(#selector(viewDidDisappear)) {(info) in
            let viewCon = info.instance() as! UIViewController
            viewCon.viewState = .viewDidDisappear
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
