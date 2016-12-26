//
//  SegmentControlProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol SegmentProtocol:PageProtocol {
    // MARK: - 根据segmentedControl的item数量来创建子控制器
    var segmentedControl:SegmentedControl {get}
}
extension SegmentProtocol where Self:BaseViewController {
    func didAddPageVC(_ edgesToFill: Bool) {
        _ = segmentedControl.rx.valueChanged({[unowned self] (segmentedControl) in
            let index = segmentedControl.selectedSegmentIndex
            if index < self.pageVC.scrollVCCount {
                self.pageVC.scroll(to: index)
            }
        })
        let pageVC:PageViewController = self.pageVC
        pageVC.currentIndexChanged.distinctUntilChanged().subscribe(onNext:{ [unowned self](index) in
            self.segmentedControl.selectedSegmentIndex = index
        }).addDisposableTo((self as BaseViewController).disposeBag)
    }
    func resetChildVC() {
        self.pageVC.scrollVCCount = self.segmentedControl.modelArray.count
        self.updateChildVC()
    }
    func configChildVC(index: Int, childVC: Self.ChildScrollVCType) {
        var viewModel:ListViewModel?
        if let tableVC = childVC as? TableViewController {
            viewModel = tableVC.viewModel
        }else if let collectionVC = childVC as? CollectionViewController {
            viewModel = collectionVC.viewModel
        }else {
            childVC.index = index
        }
        if let viewModel = viewModel {
            let model = self.segmentedControl.modelArray[index]
            viewModel.listTitle = model.title
        }
    }
}
