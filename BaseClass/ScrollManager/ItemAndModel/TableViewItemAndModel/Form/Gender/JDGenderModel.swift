//
//  JDGenderModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDGenderModel: JDFormModel {

    var gender:Variable<String?> = Variable(nil)
    
    override func configModelInit() {
        super.configModelInit()
        self.enabled = false
    }
}
extension JDGenderModel:CatchParamsProtocol,CheckParamsProtocol {
    func catchParams() -> [String : Any] {
        var params = [String:Any]()
        params[key] = gender.value
        return params
    }
    func checkParams() -> Bool {
        guard let genderStr = gender.value, genderStr.length > 0 else {
            HUD.showPrompt("请选择性别")
            return false
        }
        return true
    }
}
