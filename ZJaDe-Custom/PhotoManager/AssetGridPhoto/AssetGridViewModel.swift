//
//  AssetGridViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import Photos

class AssetGridViewModel: CollectionViewModel {
    var imageManager:PHCachingImageManager!
    
    func itemSize() -> CGSize {
        let columnCount = 4
        let width = (jd.screenWidth - (columnCount + 1).toCGFloat * 5) / columnCount.toCGFloat
        return CGSize(width: width, height: width)
    }
    
    override func configInit() {
        super.configInit()
        self.layout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = self.itemSize()
            flowLayout.scrollDirection = .vertical
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
            flowLayout.minimumLineSpacing = 5
            flowLayout.minimumInteritemSpacing = 5
            return flowLayout
        }()
    }
    override func configCollectionView(_ collectionView:CollectionView) {
        super.configCollectionView(collectionView)
        collectionView.backgroundColor = Color.viewBackground
        collectionView.register(AssetGridCell.self, forCellWithReuseIdentifier: AssetGridModel().reuseIdentifier)
    }
    override func updateCellSelectedState(_ selected: Bool, cell: CollectionCell, index: Int?) {
        UIView.spring(duration: 0.75) {
            let imageView = cell.contentView.createIfNotExisting(tag: 15, { (contentView) -> UIView in
                let imageView = ImageView()
                contentView.addSubview(imageView)
                return imageView
            }).makeLayoutView({ (imageView, maker) in
                maker.top.equalToSuperview().offset(5)
                maker.right.equalToSuperview().offset(-5)
            }) as! ImageView
            
            if selected {
                imageView.image = R.image.ic_选择_勾选()
            }else {
                imageView.image = R.image.ic_选择_未勾选()
            }
        }
    }
    // MARK: - 
    func updateImages(_ fetchResult:PHFetchResult<PHAsset>?) {
        guard let fetchResult = fetchResult else {
            return
        }
        let targetSize = self.itemSize()
        self.updateDataSource({ (dataArray) -> [(CollectionSection, [CollectionModel])]? in
            var newDataArray = dataArray.first ?? (CollectionSection(),[CollectionModel]())
            var models = [CollectionModel]()
            fetchResult.enumerateObjects({ (asset, index, stop) in
                let model = AssetGridModel()
                model.asset = asset
                self.imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: nil, resultHandler: { (image, dict) in
                    model.imageData.value = image
                })
                models.append(model)
            })
            newDataArray.1 = models
            return [newDataArray]
        })
    }
    // MARK: -
    func requestSelectedImages(_ closure:@escaping ([UIImage])->()) {
        var images = [UIImage]()
        var count:Int = 0
        self.selectedIndexPaths.map {self.getModel($0)! as! AssetGridModel}.forEach({ (model) in
            let options = PHImageRequestOptions()
            options.resizeMode = .none
            options.deliveryMode = .highQualityFormat
            self.imageManager.requestImage(for: model.asset, targetSize: self.itemSize(), contentMode: .aspectFill, options: options, resultHandler: { (image, dict) in
                if let image = image {
                    images.append(image)
                }
                count += 1
                if count == self.selectedIndexPaths.count {
                    closure(images)
                }
            })
        })
    }
}
