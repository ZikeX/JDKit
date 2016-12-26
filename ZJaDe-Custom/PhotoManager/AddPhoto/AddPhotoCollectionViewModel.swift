//
//  AddPhotoCollectionViewModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/5.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class AddPhotoCollectionViewModel: CollectionViewModel {
    var maxImageCount:Int = 4
    override func configInit() {
        super.configInit()
        self.layout = {
            let columnCount = 4
            let width = (jd.screenWidth - (columnCount + 1).toCGFloat * 10) / columnCount.toCGFloat
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: width, height: width)
            flowLayout.scrollDirection = .horizontal
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            flowLayout.minimumLineSpacing = 10
            flowLayout.minimumInteritemSpacing = 10
            return flowLayout
        }()
    }
    override func configCollectionView(_ collectionView:CollectionView) {
        super.configCollectionView(collectionView)
        collectionView.backgroundColor = Color.white
        collectionView.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoModel().reuseIdentifier)
        collectionView.snp.makeConstraints { (maker) in
            maker.size.equalTo(CGSize(width: jd.screenWidth, height: 100)).priority(900)
        }
    }
    override func getLocalSectionModels() -> [(CollectionSection, [CollectionModel])]? {
        var models = [AddPhotoModel(image: R.image.ic_addPhoto()!)]
        for _ in 0..<3 {
            models.insert(AddPhotoModel(image: R.image.ic_default_image()!), at: 0)
        }
        return [(CollectionSection(),models)]
    }
}
extension AddPhotoCollectionViewModel {
    override func didSelectItemAt(indexPath: IndexPath, model: CollectionModel) {
        //添加图片
    }
}
