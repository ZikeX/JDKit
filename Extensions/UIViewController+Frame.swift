//
//  UIViewController+Frame.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension UIViewController {
    // MARK: - VC Container
    var top: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.top
            }
            if let nav = self.navigationController {
                if nav.isNavigationBarHidden {
                    return view.top
                } else {
                    return nav.navigationBar.bottom
                }
            } else {
                return view.top
            }
        }
    }
    var bottom: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.bottom
            }
            if let tab = tabBarController {
                if tab.tabBar.isHidden {
                    return view.bottom
                } else {
                    return tab.tabBar.top
                }
            } else {
                return view.bottom
            }
        }
    }
    var applicationFrame: CGRect {
        get {
            return CGRect(x: view.x, y: top, width: view.width, height: bottom - top)
        }
    }
}
