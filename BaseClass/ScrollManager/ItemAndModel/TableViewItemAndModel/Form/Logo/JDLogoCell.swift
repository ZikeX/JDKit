//
//  JDLogoCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDLogoCell: JDFormCell {
    var imgBgView = UIView()
    var centerImageView = ImageView()
    var centerLabel = UILabel(color: Color.black, font: Font.h5)
    
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = centerImageView
        stackView.makeLayoutView { (view, maker) in
            maker.centerY.equalToSuperview()
        }
        let centerStackView = UIStackView(axis: .vertical, alignment: .center, distribution: .equalCentering, spacing: 10)
        self.jdContentView.addSubview(centerStackView)
        centerStackView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        centerStackView.addArrangedSubview(imgBgView)
        centerStackView.addArrangedSubview(centerLabel)
        
        imgBgView.addSubview(centerImageView)
        imgBgView.backgroundColor = Color.clear
        centerImageView.edgesToView()
        centerImageView.clipsToBounds = true
        centerImageView.isUserInteractionEnabled = true
    }
}
extension JDLogoCell {
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDLogoModel else {
            return
        }
        model.centerTitle.asObservable().subscribe(onNext:{[unowned self] (text) in
            self.centerLabel.text = text
        }).addDisposableTo(disposeBag)
        
        centerImageView.rx.whenTouch { (image) in
            AddPhoto().callback { (images) in
                logDebug(images)
            }.show()
        }.addDisposableTo(disposeBag)
    }
    
}

