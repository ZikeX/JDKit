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
    lazy var addPhotoModel:AddPhotoModel = AddPhotoModel(image: R.image.ic_addPhoto()!)
    override func getLocalSectionModels() -> [(CollectionSection, [CollectionModel])]? {
        return [(CollectionSection(),[addPhotoModel])]
    }
}
extension AddPhotoCollectionViewModel {
    override func didSelectItemAt(indexPath: IndexPath, model: CollectionModel) {
        guard let model = model as? AddPhotoModel else {
            return
        }
        if self.addPhotoModel == model {
            addPhoto()
        }else {
            delectPhoto(model)
        }
    }
    var models:[AddPhotoModel]? {
        return self.dataArray.last?.1 as? [AddPhotoModel]
    }
    var section:CollectionSection? {
        return self.dataArray.last?.0
    }
    func addPhoto() {
        var models = self.models?.filter({$0 != self.addPhotoModel}) ?? [AddPhotoModel]()
        let count = self.maxImageCount - models.count
        guard count > 0 else {
            Alert.showPrompt("您的图片数已达到最大可上传数量")
            return
        }
        let section = self.section ?? CollectionSection()
        AddPhotoManager().config({ (manager) in
            manager.maxImageCount = count
        }).callback {[unowned self] (urls, images) in
            let newModels = urls.lazy.map({ (url) -> AddPhotoModel in
                let model = AddPhotoModel()
                model.imageData.value = url
                return model
            })
            for model in newModels {
                if models.count < self.maxImageCount {
                    models.append(model)
                }else {
                    break
                }
            }
            if models.count < self.maxImageCount {
                models.append(self.addPhotoModel)
            }
            self.updateDataSource({ (oldDataArray) -> [(CollectionSection, [CollectionModel])]? in
                return [(section,models)]
            })
            }.show()
    }
    func delectPhoto(_ model:AddPhotoModel) {
        
        Alert.showChoice(title: "删除图片", "确定要删除图片吗？", {
            if var models = self.models,let index = models.index(of: model) {
                self.updateDataSource({ (oldDataSection) -> [(CollectionSection, [CollectionModel])]? in
                    models.remove(at: index)
                    if models.count < self.maxImageCount, !models.contains(self.addPhotoModel) {
                        models.append(self.addPhotoModel)
                    }
                    return [(self.section!,models)]
                })
            }else {
                Alert.showPrompt("删除失败")
            }
        })
    }
}
