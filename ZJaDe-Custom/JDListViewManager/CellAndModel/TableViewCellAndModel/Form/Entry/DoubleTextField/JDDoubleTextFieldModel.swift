//
//  JDDoubleTextFieldModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/9.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDDoubleTextFieldModel: JDTextFieldModel {
    var buttonClick = PublishSubject<Void>()
    
    var secondEntryType:EntryType?
    
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
        
    }
}
