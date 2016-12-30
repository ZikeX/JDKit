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
        self.spaceEdges = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.cellContentHeight = jd.screenWidth * 0.4
    }
}
