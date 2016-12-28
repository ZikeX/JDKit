//
//  JDLabelModel.swift
//  TableViewExtensionDemo
//
//  Created by Z_JaDe on 16/8/28.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDLabelModel: JDFormModel {
    var detailTitle:Variable<String?> = Variable("")
    var detailAttributeTitle:Variable<NSAttributedString?> = Variable(nil)

    convenience init(image:UIImage? = nil,title:String? = nil,detailTitle:String? = nil) {
        self.init(image: image, title: title)
        self.detailTitle.value = detailTitle
    }
    override func configModelInit() {
        super.configModelInit()
        cellHeight = 45
    }
}
extension JDLabelModel {    
    var detailTitleIsEmpty:Bool {
        return self.detailTitle.value?.isEmpty != false && detailAttributeTitle.value == nil
    }
}
extension JDLabelModel:CatchParamsProtocol,CheckParamsProtocol {
    func catchParams() -> [String : Any] {
        var params = [String:Any]()
        params[key] = detailTitle.value
        return params
    }
    func checkParams() -> Bool {
        guard let detailTitle = detailTitle.value, detailTitle.length > 0 else {
            HUD.showPrompt("您还没有完善信息！")
            return false
        }
        return true
    }
}
