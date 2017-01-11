//
//  AddPhotoCollectionCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/11.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit

class AddPhotoCollectionCell: JDFormCell {
    lazy var collectionViewModel:AddPhotoCollectionViewModel = AddPhotoCollectionViewModel()
    override func configItemInit() {
        super.configItemInit()
        let collectionView = self.collectionViewModel.createCollectionView()
        jdContentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { (maker) in
            maker.topSpace(stackView).offset(5)
            maker.left.bottom.centerX.equalToSuperview()
        }
    }
    
    override func configItem(_ model: TableModel) {
        super.configItem(model)
        guard let model = model as? AddPhotoCollectionModel else {
            return
        }
        model.dataModel.asObservable().subscribe(onNext:{[unowned self] (models) in
            self.collectionViewModel.appendPhotos(models)
            model.urlArray = self.mapToUrl(models)
        }).addDisposableTo(disposeBag)
        
        self.collectionViewModel.phtotosChanged.subscribe(onNext:{[unowned self] (models) in
            model.urlArray = self.mapToUrl(models)
        }).addDisposableTo(disposeBag)
    }
    func mapToUrl(_ models:[AddPhotoModel]) -> [String] {
        return models.map{$0.imageData.value}.filter{$0 is String} as! [String]
    }
    
    override func configTitleLabel(titleLabel: UILabel) {
        super.configTitleLabel(titleLabel: titleLabel)
        titleLabel.textColor = Color.gray
    }
}
