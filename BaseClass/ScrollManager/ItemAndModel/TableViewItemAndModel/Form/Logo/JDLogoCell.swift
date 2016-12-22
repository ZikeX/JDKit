//
//  JDLogoCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDLogoCell: JDFormCell {
    var centerButton = Button()
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = centerButton
        stackView.makeLayoutView { (view, maker) in
            maker.centerY.equalToSuperview()
        }
        self.jdContentView.addSubview(centerButton)
        centerButton.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        
        centerButton.titleAndImgLocation = .bottomToTop
        centerButton.itemSpace = 10
        centerButton.imgView.clipsToBounds = true
        centerButton.textLabel.textColor = Color.black
        centerButton.textLabel.font = Font.h5
    }
}
extension JDLogoCell {
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDLogoModel else {
            return
        }
        model.centerTitle.asObservable().subscribe(onNext:{[unowned self] (text) in
            self.centerButton.textStr = text
        }).addDisposableTo(disposeBag)
        
        centerButton.rx.touchUpInside { (button) in
            // TODO: 点击此处选择图片
        }.addDisposableTo(disposeBag)
    }
    
}

