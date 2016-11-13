//
//  BaseNavigationController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationBar.backIndicatorImage = R.image.ic_back()
//        self.navigationBar.backIndicatorTransitionMaskImage = R.image.ic_back()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.topViewController
    }
}
