//
//  JDUserPhotoModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDUserPhotoModel: JDLogoModel {
    
    var logoImgSize = CGSize(width: 70, height: 70)
    
    override func configModelInit() {
        super.configModelInit()
        self.spaceEdges = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        self.cellContentHeight = jd.screenWidth * 0.4
    }
}
