//
//  UINavigationController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension UINavigationController {
    func popAndPush(count:Int,pushVC:UIViewController,animated:Bool) {
        var vcArr = self.viewControllers
        vcArr.removeLast(count)
        vcArr.append(pushVC)
        self.setViewControllers(vcArr, animated: animated)
    }
}
