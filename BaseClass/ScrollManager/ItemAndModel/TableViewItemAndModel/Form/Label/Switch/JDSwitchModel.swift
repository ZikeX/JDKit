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
    let isOn = Variable(false)
    let valueChanged = PublishSubject<Bool>()
    
    override func configModelInit() {
        super.configModelInit()
        separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
    }
}
extension JDSwitchModel:CatchParamsProtocol {
    func catchParms() -> [String : Any] {
        var params = [String:Any]()
        params[key] = isOn.value
        return params
    }
}
