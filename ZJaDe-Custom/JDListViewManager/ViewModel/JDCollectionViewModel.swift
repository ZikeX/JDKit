//
//  JDCollectionViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDCollectionViewModel: JDListViewModel {
    weak var collectionView:JDCollectionView!
    weak var listVC:JDCollectionViewController?
    
    convenience init(collectionView:JDCollectionView) {
        self.init()
        self.collectionView = collectionView
    }
    
    var sectionModelsChanged = PublishSubject<[AnimatableSectionModel<JDCollectionSection,JDCollectionModel>]>()
    let rxDataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<JDCollectionSection,JDCollectionModel>>()
    var dataArray = [(JDCollectionSection,[JDCollectionModel])]()
    
    func configCollectionView(collectionView:JDCollectionView) {
        
    }
    func getLocalSectionModels() -> [(JDCollectionSection, [JDCollectionModel])]? {
        return nil
    }
}
extension JDCollectionViewModel:UICollectionViewDelegate {
    // MARK: - display
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionCell {
            let model = rxDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionCell {
            let model = rxDataSource[indexPath]
            cell.cellDidDisappear(model)
        }
    }
}
