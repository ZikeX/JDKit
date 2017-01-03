//
//  AssetGridViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import Photos
class AssetGridViewController: BaseViewController {
    var callBack:([UIImage])->() = { (images) in
        logDebug("回调没有写")
    }
    
    var maxImageCount:Int = 1 {
        didSet {
            self.viewModel.maxSelectedCount = maxImageCount
            
        }
    }
    var fetchResult: PHFetchResult<PHAsset>!
    fileprivate let imageManager = PHCachingImageManager()
    
    lazy var viewModel:AssetGridViewModel = {
        let viewModel = AssetGridViewModel()
        viewModel.maxSelectedCount = self.maxImageCount
        viewModel.imageManager = self.imageManager
        return viewModel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBarItem { (navItem) in
            navItem.title = "选择图片"
            navItem.leftBarButtonItem = self.cacelButton.barButtonItem()
            navItem.rightBarButtonItem = self.doneButton.barButtonItem()
            self.doneButton.textStr = "选择"
            self.doneButton.sizeToFit()
        }
        
        self.viewModel.selectedIndexPathsChanged.map{$0.count}.distinctUntilChanged().subscribe(onNext:{ [unowned self](count) in
            self.doneButton.textStr = "已选择\(count)张"
            self.doneButton.sizeToFit()
            self.navBar?.setNeedsLayout()
        }).addDisposableTo(disposeBag)
        PHPhotoLibrary.shared().register(self)
        loadPhotos()
        addChildScrollVC()
    }
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    func loadPhotos() {
        if fetchResult == nil {
            let allPhotosOptions = PHFetchOptions()
            allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchResult = PHAsset.fetchAssets(with: allPhotosOptions)
            self.viewModel.updateImages(fetchResult)
        }
    }
    override func checkAndSubmit(_ button:Button) {
        if self.viewModel.selectedIndexPaths.count > 0 {
            self.viewModel.requestSelectedImages({ (images) in
                self.callBack(images)
                self.cacelVC()
            })
        }else {
            Alert.showChoice(title: "选择图片", "您还没有选择图片确定要关闭吗？", {
                self.cacelVC()
            })
        }
    }
}
// MARK: PHPhotoLibraryChangeObserver
extension AssetGridViewController: PHPhotoLibraryChangeObserver{
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        guard let changes = changeInstance.changeDetails(for: fetchResult)
            else { return }
        DispatchQueue.main.sync {
            fetchResult = changes.fetchResultAfterChanges
            self.viewModel.updateImages(fetchResult)
        }
    }
}
extension AssetGridViewController:AddChildListProtocol {
    func createListViewModel(index: Int) -> AssetGridViewModel {
        return self.viewModel
    }
}

