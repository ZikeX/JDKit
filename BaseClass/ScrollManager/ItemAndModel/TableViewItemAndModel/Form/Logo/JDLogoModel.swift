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
    
    convenience init(image:UIImage? = nil,title:String? = nil,logo:UIImage? = nil) {
        self.init(image: image, title: title)
        self.logo.value = logo
    }
    
    var logo:Variable<UIImage?> = Variable(nil)
    
    override func configModelInit() {
        super.configModelInit()
        cellContentHeight = 70
        
        spaceEdges = UIEdgeInsetsMake(8, 20, 8, 20)
    }
    var logoClick = PublishSubject<ImageView>()
}
