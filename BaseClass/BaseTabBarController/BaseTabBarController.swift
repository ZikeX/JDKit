//
//  BaseTabBarController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import JDAnimatedTabBarController

class BaseTabBarController: JDAnimatedTabBarController {
    
    override func configInit() {
        super.configInit()
        self.automaticallyAdjustsScrollViewInsets = false
        configInitAboutNavBar()
        configInitAboutViewState()
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.selectedViewController
    }
}
