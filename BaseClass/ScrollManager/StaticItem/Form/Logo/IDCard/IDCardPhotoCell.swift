//
//  IDCardPhotoCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/30.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class IDCardPhotoCell: JDCenterPhotoCell {
    
    override func touchCenterImageView(_ model:JDLogoModel) {
        if self.titleLabel.text == "正面" {
            self.centerImageView.image = R.image.ic_IDCard_上传成功()
            self.centerLabel.text = "上传成功"
            self.centerLabel.textColor = Color.tintColor
        }else {
            self.centerImageView.image = R.image.ic_IDCard_上传失败()
            self.centerLabel.text = "上传失败"
            self.centerLabel.textColor = Color.red
        }
    }
}
