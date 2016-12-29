//
//  JDCenterPhotoCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDCenterPhotoCell: JDLogoCell {
    
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = centerImageView
    }
}
extension JDCenterPhotoCell {
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDCenterPhotoModel else {
            return
        }
        let placeholderImage = model.placeholderImage
        model.logo.asObservable().subscribe(onNext:{[unowned self] (url) in
            self.centerImageView.setImage(imageData: url,placeholderImage:placeholderImage)
        }).addDisposableTo(disposeBag)
    }
    override func touchCenterImageView() {
        
    }
}
