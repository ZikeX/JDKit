//
//  JDLabelModel.swift
//  JDTableViewExtensionDemo
//
//  Created by Z_JaDe on 16/8/28.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDLabelModel: JDFormModel {
    var detailTitle:Variable<String?> = Variable("")

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
        return self.detailTitle.value?.isEmpty != false
    }
}