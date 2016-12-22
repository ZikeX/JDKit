//
//  JDUserPhotoCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDUserPhotoCell: JDLogoCell {
    override func configItemInit() {
        super.configItemInit()
        centerButton.imgView.snp.makeConstraints { (maker) in
            maker.size.equalTo(CGSize(width: 70, height: 70))
        }
        centerButton.imgView.cornerRadius = 35
    }
}
extension JDUserPhotoCell {
    override func configItem(_ model: JDTableModel) {
        super.configItem(model)
        guard let model = model as? JDUserPhotoModel else {
            return
        }
        centerButton.imgView.snp.updateConstraints { (maker) in
            maker.size.equalTo(model.logoImgSize)
        }
        centerButton.imgView.cornerRadius = min(model.imageSize.width, model.imageSize.height)
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDUserPhotoModel else {
            return
        }
        model.logo.asObservable().subscribe(onNext:{[unowned self] (image) in
            let image = image ?? R.image.ic_default_userImg()!
            self.centerButton.img = image
        }).addDisposableTo(disposeBag)
    }
}
