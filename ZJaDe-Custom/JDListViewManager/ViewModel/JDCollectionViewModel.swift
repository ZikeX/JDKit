//
//  JDCollectionViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDCollectionViewModel: JDListViewModel {
    var layout:UICollectionViewLayout = UICollectionViewFlowLayout()
    
    weak var collectionView:JDCollectionView!
    weak var listVC:JDCollectionViewController?
    
    var sectionModelsChanged = PublishSubject<[AnimatableSectionModel<JDCollectionSection,JDCollectionModel>]>()
    let rxDataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<JDCollectionSection,JDCollectionModel>>()
    var dataArray = [(JDCollectionSection,[JDCollectionModel])]()
    
    // MARK: - 
    func resetInit() {/// ZJaDe: 当self被设置进入collectionView之后调用
        self.configCollectionView(collectionView)
        self.loadLocalSectionModels()
        collectionView.emptyDataSetView.configEmptyDataSetData {[unowned self] (state, contentView) in
            switch state {
            case .loading:
                self.configEmptyDataSetLoading(contentView)
            case .loadFailed:
                self.configEmptyDataSetLoadFailed(contentView)
            case .loaded:
                self.configEmptyDataSetNoData(contentView)
            }
        }
    }
    func configCollectionView(_ collectionView:JDCollectionView) {
        
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
