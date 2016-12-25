//
//  JDBgImageCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDBgImageCell: JDLogoCell {
    
    var bgImageView = ImageView()
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = centerImageView
        
        self.jdContentView.insertSubview(bgImageView, at: 0)
        bgImageView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
}
extension JDBgImageCell {
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDBgImageModel else {
            return
        }
        model.logo.asObservable().subscribe(onNext:{[unowned self] (image) in
            self.bgImageView.image = image
        }).addDisposableTo(disposeBag)
        
        model.centerImage.asObservable().subscribe(onNext:{[unowned self] (image) in
            self.centerImageView.image = image ?? R.image.ic_default_image()!
        }).addDisposableTo(disposeBag)
        
    }
}
extension JDBgImageCell {
    override func configCell() {
        super.configCell()
        self.backgroundColor = Color.clear
    }
}
