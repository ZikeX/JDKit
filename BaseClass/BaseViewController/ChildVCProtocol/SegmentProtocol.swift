//
//  SegmentControlProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol SegmentProtocol:TransitionProtocol {
    var segmentedControl:SegmentedControl {get}
    // MARK: - 根据segmentedControl的item数量来创建子控制器
}
extension SegmentProtocol where Self:BaseViewController {
    func didAddTransitionVC(_ edgesToFill: Bool) {
        _ = segmentedControl.rx.value.asObservable().subscribe(onNext: {[unowned self] (index) in
            if index < self.transitionVC.scrollVCCount {
                self.transitionVC.selectedIndex = index
            }
        })
    }
    func updateChildVC() {
        self.transitionVC.clearAllChildVC()
        self.transitionVC.scrollVCCount = self.segmentedControl.modelArray.count
        self.transitionVC.createScrollVCClosure = {[unowned self] (index) in
            let listVC = self.addChildScrollVC(edgesToFill: nil, index: index)
            var viewModel:ListViewModel?
            if let tableVC = listVC as? TableViewController {
                viewModel = tableVC.viewModel
            }else if let collectionVC = listVC as? CollectionViewController {
                viewModel = collectionVC.viewModel
            }
            if let viewModel = viewModel {
                let model = self.segmentedControl.modelArray[index]
                viewModel.listTitle = model.title
            }
            return listVC
        }
        self.transitionVC.transition()
    }
}
