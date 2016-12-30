//
//  JDBgImageModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDBgImageModel: JDLogoModel {
    
    convenience init(image:UIImage? = nil,title:String? = nil,logo:String? = nil,centerTitle:String? = nil,centerImage:UIImage? = nil) {
        self.init(image: image, title: title, logo: logo, centerTitle: centerTitle)
        self.centerImage.value = centerImage
    }
    
    var centerImage:Variable<UIImage?> = Variable(nil)
    
    override func configModelInit() {
        super.configModelInit()
        self.spaceEdges = UIEdgeInsets()
        self.cellContentHeight = jd.screenWidth * 0.4
        self.enabled = false
    }
}
