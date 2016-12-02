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
    override var listTitle:String? {
        didSet {
            self.listVC?.title = self.listTitle
        }
    }
    
    var sectionModelsChanged = PublishSubject<[AnimatableSectionModel<JDCollectionSection,JDCollectionModel>]>()
    let rxDataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<JDCollectionSection,JDCollectionModel>>()
    var dataArray = [(JDCollectionSection,[JDCollectionModel])]()
    var headerModelArray = [IndexPath:JDCollectionReusableModel]()
    var footerModelArray = [IndexPath:JDCollectionReusableModel]()
    
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
extension JDCollectionViewModel {
    override func whenCellSelected(_ indexPath:IndexPath) {
        guard let maxSelectedCount = maxSelectedCount,maxSelectedCount > 0 else {
            return
        }
        super.whenCellSelected(indexPath)
        
        let cell = collectionView.cellForItem(at: indexPath) as? JDCollectionCell
        cell?.updateSelectedState(true,index: self.selectedIndexPaths.count-1)
        self.rxDataSource[indexPath].isSelected = true
        while self.selectedIndexPaths.count > maxSelectedCount {
            let firstIndexPath = self.selectedIndexPaths.removeFirst()
            let firstCell = collectionView.cellForItem(at: firstIndexPath) as? JDCollectionCell
            firstCell?.updateSelectedState(false,index: nil)
            self.rxDataSource[firstIndexPath].isSelected = false
        }
        self.selectedIndexPaths.enumerated().forEach({ (index,indexPath) in
            let eachCell = collectionView.cellForItem(at: indexPath) as? JDCollectionCell
            eachCell?.updateSelectedState(true, index: index)
        })
    }
}
extension JDCollectionViewModel {
    // MARK: - 自定义代理
    func didSelectItemAt(indexPath:IndexPath,model:JDCollectionModel) {
        
    }
}
// MARK: - supplementary Views
extension JDCollectionViewModel {
}
extension JDCollectionViewModel:UICollectionViewDelegateFlowLayout {
    func getModel(_ indexPath:IndexPath) -> JDCollectionModel? {
        return try? collectionView.rx.model(at: indexPath)
    }
    // MARK: cell display
    final func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionCell {
            let model = getModel(indexPath)!
            cell.itemDidLoad(model)
            cell.itemWillAppear(model)
        }
    }
    final func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionCell {
            let model = getModel(indexPath)
            cell.itemDidDisappear(model)
        }
    }
    // MARK: didSelectItemAt
    final func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let model = getModel(indexPath)!
        return model.enabled ?? true
    }
    final func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = getModel(indexPath)!
        self.didSelectItemAt(indexPath: indexPath, model: model)
    }
    // MARK: supplementaryView display
    func getReusableModel(_ indexPath:IndexPath,kind:String) -> JDCollectionReusableModel? {
        let model:JDCollectionReusableModel?
        if kind == UICollectionElementKindSectionHeader {
            model = headerModelArray[indexPath]
        }else if kind == UICollectionElementKindSectionFooter {
            model = footerModelArray[indexPath]
        }else {
            fatalError("kind错误-->\(kind)")
        }
        return model
    }
    final func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if let view = view as? JDCollectionReusableView {
            let model = getReusableModel(indexPath, kind: elementKind)!
            view.itemDidLoad(model)
            view.itemWillAppear(model)
        }
    }
    final func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if let view = view as? JDCollectionReusableView {
            let model = getReusableModel(indexPath, kind: elementKind)
            view.itemDidDisappear(model)
        }
    }
}
