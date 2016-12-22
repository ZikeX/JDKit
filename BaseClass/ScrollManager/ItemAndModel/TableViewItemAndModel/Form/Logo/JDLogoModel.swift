//
//  JDLogoModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDLogoModel: JDFormModel {
    
    convenience init(image:UIImage? = nil,title:String? = nil,logo:UIImage? = nil,centerTitle:String? = nil) {
        self.init(image: image, title: title)
        self.logo.value = logo
        self.centerTitle.value = centerTitle
    }
    var logo:Variable<UIImage?> = Variable(nil)
    var centerTitle:Variable<String?> = Variable(nil)
    
    override func configModelInit() {
        super.configModelInit()
        
    }
    var logoClick = PublishSubject<Button>()
}
