//
//  JDLabelModel.swift
//  JDTableViewExtensionDemo
//
//  Created by Z_JaDe on 16/8/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDLabelModel: JDFormModel {
    var detailTitle:Variable<String?> = Variable("")
    var detailTitleLabelAppearanceClosure:LabelAppearanceClosure = { (detailTitleLabel) in
        detailTitleLabel.textColor = Color.gray
        detailTitleLabel.font = Font.h4
        detailTitleLabel.numberOfLines = 0
        detailTitleLabel.textAlignment = .right
    }
    convenience init(image:UIImage? = nil,title:String? = nil,detailTitle:String? = nil) {
        self.init(image: image, title: title)
        self.detailTitle.value = detailTitle
    }
    override func configModelInit() {
        super.configModelInit()
    }
}
extension JDLabelModel {    
    var detailTitleIsEmpty:Bool {
        return self.detailTitle.value?.isEmpty != false
    }
}
