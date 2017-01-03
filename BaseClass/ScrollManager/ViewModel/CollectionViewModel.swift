//
//  CollectionViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class CollectionViewModel: ListViewModel {
    var layout:UICollectionViewLayout = UICollectionViewFlowLayout()
    weak var collectionView:CollectionView!
    weak var listVC:CollectionViewController?
    override var listTitle:String? {
        didSet {
            self.listVC?.title = self.listTitle
        }
    }
    
    var sectionModelsChanged = PublishSubject<[AnimatableSectionModel<CollectionSection,CollectionModel>]>()
    let rxDataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<CollectionSection,CollectionModel>>()
    var dataArray = [(CollectionSection,[CollectionModel])]()
    var headerModelArray = [IndexPath:CollectionReusableModel]()
    var footerModelArray = [IndexPath:CollectionReusableModel]()
    
    override func configInit() {
        super.configInit()
        
    }
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
    func configCollectionView(_ collectionView:CollectionView) {
        
    }
    func getLocalSectionModels() -> [(CollectionSection, [CollectionModel])]? {
        return nil
    }
    // MARK: - 
    func createCollectionView() -> CollectionView {
        let collectionView = CollectionView(viewModel: self)
        self.resetInit()
        return collectionView
    }
    // MARK: - CellSelectedState
    override func whenCellSelected(_ indexPath:IndexPath) {
        guard self.maxSelectedCount > 0 else {
            return
        }
        super.whenCellSelected(indexPath)
        
        self.getModel(indexPath)!.isSelected = self.selectedIndexPaths.contains(indexPath)
        while self.selectedIndexPaths.count > maxSelectedCount {
            let firstIndexPath = self.selectedIndexPaths.removeFirst()
            self.getModel(firstIndexPath)?.isSelected = false
        }
        selectedIndexPathsChanged.onNext(self.selectedIndexPaths)
        
        self.collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            guard let cell = self.collectionView.cellForItem(at: indexPath) as? CollectionCell else {
                return
            }
            if let index = self.selectedIndexPaths.index(of: indexPath) {
                updateCellSelectedState(true, cell: cell, index: index)
            }else {
                updateCellSelectedState(false, cell: cell, index: nil)
            }
        }
    }
    func updateCellSelectedState(_ selected:Bool,cell:CollectionCell,index:Int?) {
        fatalError("待实现")
    }
}
extension CollectionViewModel {
    // MARK: - 自定义代理
    func didSelectItemAt(indexPath:IndexPath,model:CollectionModel) {
        
    }
}
// MARK: - supplementary Views
extension CollectionViewModel {
}
extension CollectionViewModel:UICollectionViewDelegateFlowLayout {
    func getModel(_ indexPath:IndexPath) -> CollectionModel? {
        guard indexPath.section < rxDataSource.sectionModels.count else {
            return nil
        }
        let sectionModel = rxDataSource[indexPath.section]
        guard indexPath.row < sectionModel.items.count else {
            return nil
        }
        return sectionModel.items[indexPath.row]
    }
    // MARK: cell display
    final func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CollectionCell {
            let model = getModel(indexPath)!
            cell.itemWillAppear(model)
            var index:Int? = nil
            if self.maxSelectedCount > 0 {
                let modelIndex = self.selectedIndexPaths.index(of: indexPath)
                if model.isSelected && modelIndex == nil {
                    self.selectedIndexPaths.append(indexPath)
                    index = self.selectedIndexPaths.count - 1
                }else if model.isSelected == false, let index = modelIndex {
                    self.selectedIndexPaths.remove(at: index)
                }
                updateCellSelectedState(model.isSelected, cell: cell, index: index)
            }
        }
    }
    final func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? CollectionCell {
            let model = getModel(indexPath)
            cell.itemDidDisappear(model)
        }
    }
    // MARK: didSelectItemAt
    final func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        let model = getModel(indexPath)!
        return model.enabled
    }
    final func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        whenCellSelected(indexPath)
        
        let model = getModel(indexPath)!
        self.didSelectItemAt(indexPath: indexPath, model: model)
    }
    // MARK: supplementaryView display
    func getReusableModel(_ indexPath:IndexPath,kind:String) -> CollectionReusableModel? {
        let model:CollectionReusableModel?
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
        if let view = view as? CollectionReusableView {
            let model = getReusableModel(indexPath, kind: elementKind)!
            view.itemDidLoad(model)
            view.itemWillAppear(model)
        }
    }
    final func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if let view = view as? CollectionReusableView {
            let model = getReusableModel(indexPath, kind: elementKind)
            view.itemDidDisappear(model)
        }
    }
}
