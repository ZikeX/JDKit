//
//  TransitionProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

protocol TransitionProtocol:AddChildScrollProtocol {
    var transitionVC:TransitionViewController {get set}
    // MARK: - 调用下面方法可以添加transitionVC到本控制器
    func addTransitionVC(edgesToFill:Bool)
    // MARK: - 创建transitionVC之后的一些设置
    func configTransitionVC(edgesToFill: Bool)
    // MARK: - 如果有segmentedControl,则绑定segmentedControl和transitionVC，并根据segmentedControl的item数量来创建子控制器
    func configSegmentedControlToVC(segmentedControl:SegmentedControl, _ closure:((ChildListViewModelType?,Int)->())?)
    // MARK: - 如果有segmentedControl,则根据segmentedControl的item数量来创建子控制器，否则只创建一个子控制器
    func updateTransitionChildVC(segmentedControl:SegmentedControl?, _ closure:((ChildListViewModelType?,Int)->())?)
}
extension TransitionProtocol where Self:BaseViewController {
    func addTransitionVC(edgesToFill:Bool = false) {
        self.transitionVC.edgesToVC(self, edgesToFill: edgesToFill)
        self.configTransitionVC(edgesToFill: edgesToFill)
    }
    // MARK: -
    func configSegmentedControlToVC(segmentedControl:SegmentedControl, _ closure:((ChildListViewModelType?,Int)->())? = nil) {
        _ = segmentedControl.rx.value.asObservable().subscribe(onNext: {[unowned self] (index) in
            if index < self.transitionVC.scrollVCCount {
                self.transitionVC.selectedIndex = index
            }
        })
        updateTransitionChildVC(segmentedControl: segmentedControl,closure)
    }
    func updateTransitionChildVC(segmentedControl:SegmentedControl?, _ closure:((ChildListViewModelType?,Int)->())? = nil) {
        /// ZJaDe: 根据segmentedControl的item个数来创建子控制器，如果segmentedControl为空则只创建1次
        self.transitionVC.clearAllChildVC()
        self.transitionVC.scrollVCCount = segmentedControl?.modelArray.count ?? 1
        self.transitionVC.createScrollVCClosure = {[unowned self] (index) in
            let (viewModel,listVC) = self.addChildScrollVC(edgesToFill: nil, index: index)
            closure?(viewModel,index)
            return listVC
        }
        self.transitionVC.transition()
    }
}
