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
    func supplementaryHeaderView(collectionView:JDCollectionView, indexPath:IndexPath) -> UICollectionReusableView {
        fatalError("既然headerView的size不是(0,0),子类就要实现这个方法了")
    }
    func supplementaryFooterView(collectionView:JDCollectionView, indexPath:IndexPath) -> UICollectionReusableView {
        fatalError("既然footerView的size不是(0,0),子类就要实现这个方法了")
    }
    func supplementaryHeaderViewWillDisplay(collectionView:JDCollectionView, indexPath:IndexPath) {
        
    }
    func supplementaryFooterViewWillDisplay(collectionView:JDCollectionView, indexPath:IndexPath) {

    }
    func supplementaryHeaderViewDidEndDisplaying(collectionView:JDCollectionView, indexPath:IndexPath) {
        
    }
    func supplementaryFooterViewDidEndDisplaying(collectionView:JDCollectionView, indexPath:IndexPath) {
        
    }
}
extension JDCollectionViewModel:UICollectionViewDelegateFlowLayout {
    // MARK: cell display
    final func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionCell {
            let model = rxDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    final func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionCell {
            let model:JDCollectionModel? = try? collectionView.rx.model(at: indexPath)
            cell.cellDidDisappear(model)
        }
    }
    // MARK: didSelectItemAt
    final func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let model = rxDataSource[indexPath]
        return model.enabled ?? true
    }
    final func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = rxDataSource[indexPath]
        self.didSelectItemAt(indexPath: indexPath, model: model)
    }
    // MARK: supplementaryView display
    final func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionElementKindSectionHeader {
            self.supplementaryHeaderViewWillDisplay(collectionView: collectionView as! JDCollectionView, indexPath: indexPath)
        }else if elementKind == UICollectionElementKindSectionFooter {
            self.supplementaryFooterViewWillDisplay(collectionView: collectionView as! JDCollectionView, indexPath: indexPath)
        }else {
            fatalError("kind错误-->\(elementKind)")
        }
    }
    final func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionElementKindSectionHeader {
            self.supplementaryHeaderViewDidEndDisplaying(collectionView: collectionView as! JDCollectionView, indexPath: indexPath)
        }else if elementKind == UICollectionElementKindSectionFooter {
            self.supplementaryFooterViewDidEndDisplaying(collectionView: collectionView as! JDCollectionView, indexPath: indexPath)
        }else {
            fatalError("kind错误-->\(elementKind)")
        }
    }
}
