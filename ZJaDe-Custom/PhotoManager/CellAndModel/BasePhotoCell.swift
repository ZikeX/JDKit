//
//  BasePhotoCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/26.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
class BasePhotoCell: BaseCollectionCell {
    lazy var imageView:ImageView = ImageView()
    
    override func itemDidInit() {
        super.itemDidInit()
        self.contentView.addSubview(self.imageView)
        self.imageView.edgesToView()
        self.imageView.contentMode = .scaleAspectFill
    }
    override func bindingModel(_ model: CollectionModel) {
        guard let model = model as? BasePhotoModel else {
            return
        }
        model.imageData.asObservable().subscribe(onNext:{ [unowned self](imageData) in
            self.imageView.setImage(imageData: imageData)
        }).addDisposableTo(disposeBag)
    }
}
