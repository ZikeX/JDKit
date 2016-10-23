//
//  JDSwitchModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDSwitchModel: JDLabelModel {
    var isOn = Variable(false)
    var switchAppearanceClosure:SwitchAppearanceClosure?
    override func configModelInit() {
        super.configModelInit()
        separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
    }
}
