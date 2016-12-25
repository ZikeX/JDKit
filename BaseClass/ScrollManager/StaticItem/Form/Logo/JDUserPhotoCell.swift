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
        centerImageView.snp.makeConstraints { (maker) in
            maker.size.equalTo(CGSize(width: 70, height: 70))
        }
        centerImageView.cornerRadius = 35
    }
}
extension JDUserPhotoCell {
    override func configItem(_ model: TableModel) {
        super.configItem(model)
        guard let model = model as? JDUserPhotoModel else {
            return
        }
        centerImageView.snp.updateConstraints { (maker) in
            maker.size.equalTo(model.logoImgSize)
        }
        centerImageView.cornerRadius = min(model.logoImgSize.width, model.logoImgSize.height) / 2.0
    }
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDUserPhotoModel else {
            return
        }
        model.logo.asObservable().subscribe(onNext:{[unowned self] (image) in
            let image = image ?? R.image.ic_default_userImg()!
            self.centerImageView.image = image
        }).addDisposableTo(disposeBag)
    }
}
