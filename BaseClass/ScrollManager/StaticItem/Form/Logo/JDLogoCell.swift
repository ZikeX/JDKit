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
        centerImageView.contentMode = .scaleAspectFill
    }
}
extension JDLogoCell {
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDLogoModel else {
            return
        }
        model.centerTitle.asObservable().subscribe(onNext:{[unowned self] (text) in
            self.centerLabel.text = text
        }).addDisposableTo(disposeBag)
        
        centerImageView.rx.whenTouch {[unowned self, unowned model] (image) in
            self.touchCenterImageView(model)
        }.addDisposableTo(disposeBag)
    }
    func touchCenterImageView(_ model:JDLogoModel) {
        AddPhotoManager().callback {[weak model, weak self] (url, images) in
            model?.logo.value = url.first!
            self?.centerImageView.image = images.first!
        }.show()
    }
}

