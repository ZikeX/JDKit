//
//  JDDoubleTextFieldModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDDoubleTextFieldModel: JDTextFieldModel {
    
    var secondText:Variable<String?> = Variable("")
    var secondPlaceholder = Variable("")
    var intervalText:String = ""
    var secondTextFieldEditingState = PublishSubject<UIControlEvents>()
    
    convenience init(image:UIImage? = nil,title:String? = nil,text:String = "",placeholder:String = "",secondText:String = "",secondPlaceholder:String = "",intervalText:String = "至") {
        self.init(image: image, title: title)
        self.text.value = text
        self.placeholder.value = placeholder
        self.secondText.value = secondText
        self.secondPlaceholder.value = secondPlaceholder
        self.intervalText = intervalText
        
        self.textFieldAppearanceClosure = { (textField) in
            textField.backgroundColor = Color.viewBackground
            textField.textAlignment = .center
        }
    }
    
    var configDoubleTextFieldCellLayout:DoubleTextFieldCellLayoutClosure = { (stackView,textField,intervalLabel,secondTextField) in
        [stackView,textField,intervalLabel,secondTextField].forEach { (view) in
            view.snp.makeConstraints { (maker) in
                maker.top.centerY.equalToSuperview()
            }
        }
        textField.snp.makeConstraints({ (maker) in
            maker.leftSpace(stackView).offset(8)
        })
        intervalLabel.snp.makeConstraints({ (maker) in
            maker.leftSpace(textField).offset(8)
        })
        intervalLabel.contentHuggingHorizontalPriority = UILayoutPriorityRequired
        secondTextField.snp.makeConstraints({ (maker) in
            maker.right.equalToSuperview()
            maker.width.equalTo(textField)
            maker.leftSpace(intervalLabel).offset(8)
        })
    }
}
