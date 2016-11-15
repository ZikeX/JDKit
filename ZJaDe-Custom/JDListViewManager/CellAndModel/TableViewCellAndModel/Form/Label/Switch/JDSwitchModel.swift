//
//  JDSwitchModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDSwitchModel: JDLabelModel {
    var isOn = Variable(false)
    
    override func configModelInit() {
        super.configModelInit()
        separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
    }
}
