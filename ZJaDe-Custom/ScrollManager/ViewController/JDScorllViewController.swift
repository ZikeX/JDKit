//
//  JDScorllViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/30.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDScorllViewController: UIViewController,ScrollVCProtocol {
    var index:Int!
    var scrollView: UIScrollView {
        return self.view as! UIScrollView
    }
    override func loadView() {
        self.view = UIScrollView()
    }
    deinit {
        logDebug("\(type(of:self))->\(self)注销")
    }
}
