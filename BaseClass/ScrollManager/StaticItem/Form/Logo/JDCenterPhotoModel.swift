//
//  JDCenterPhotoModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDCenterPhotoModel: JDLogoModel {
    convenience init(image:UIImage? = nil,title:String? = nil,logo:String? = nil,centerTitle:String? = nil,placeholderImage:UIImage) {
        self.init(image: image, title: title, logo: logo, centerTitle: centerTitle)
        self.placeholderImage = placeholderImage
    }
    
    var placeholderImage:UIImage!
    
    override func configModelInit() {
        super.configModelInit()
        self.spaceEdges = UIEdgeInsetsMake(0, 0, 0, 0)
        self.cellContentHeight = jd.screenWidth * 0.4
    }
}
