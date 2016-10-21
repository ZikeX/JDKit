//
//  JDEntryModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDEntryModel: JDFormModel {
    var text = Variable("")
    var placeholder = Variable("")
    
    convenience init(image:UIImage? = nil,title:String? = nil,text:String = "",placeholder:String = "") {
        self.init(image: image, title: title)
        self.text.value = text
        self.placeholder.value = placeholder
    }
}
