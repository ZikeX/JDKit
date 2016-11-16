//
//  CustomIBProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/17.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol CustomIBProtocol {
    func configInit()
    func viewDidLoad()
    func configNeedUpdate()
}
extension CustomIBProtocol where Self:UIView {
    
    func configNeedUpdate() {
        self.isOpaque = false
        self.setNeedsUpdateConstraints()
        self.setNeedsLayout()
    }
}
