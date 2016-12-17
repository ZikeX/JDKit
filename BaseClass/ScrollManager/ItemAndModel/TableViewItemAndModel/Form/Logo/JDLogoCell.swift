//
//  JDLogoCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDLogoCell: JDFormCell {
    var logo = ImageView()
    
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = logo
        jdContentView.addSubview(logo)
        logo.cornerRadius = 35
    }
}
extension JDLogoCell {
    override func configItem(_ model: JDTableModel) {
        super.configItem(model)
        stackView.makeLayoutView { (view, maker) in
            maker.top.centerY.equalToSuperview()
        }
        logo.makeLayoutView { (logo, maker) in
            maker.centerY.top.equalToSuperview()
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(70)
        }
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDLogoModel else {
            return
        }
        self.configLogo(logo)
        
        model.logo.asObservable().subscribe(onNext:{[unowned self] (image) in
            self.logo.image = image ?? R.image.ic_default_userImg()
        }).addDisposableTo(disposeBag)
        
        self.logo.rx.whenTouch { (imageView) in
            model.logoClick.onNext(imageView)
        }.addDisposableTo(disposeBag)
        
    }
    override func unbindingModel(_ model: JDTableModel?) {
        super.unbindingModel(model)
        guard let model = model as? JDLogoModel else {
            return
        }
        model.logo.value = self.logo.image
    }
}
extension JDLogoCell {
    func configLogo(_ logo:ImageView) {
    }
    override func configCell() {
        super.configCell()
    }
}
