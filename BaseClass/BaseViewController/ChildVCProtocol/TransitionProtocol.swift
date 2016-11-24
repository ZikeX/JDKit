//
//  TransitionProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

protocol TransitionProtocol:AddChildListProtocol {
    var transitionVC:TransitionViewController {get set}
    
    func addTransitionVC(edgesToFill:Bool)
    func configTransitionVC(edgesToFill: Bool)
    
    func configSegmentedControlToVC(segmentedControl:SegmentedControl, _ closure:((ChildListViewModelType,Int)->())?)
    func updateTransitionChildVC(segmentedControl:SegmentedControl?, _ closure:((ChildListViewModelType,Int)->())?)
}
extension TransitionProtocol where Self:BaseViewController {
    func addTransitionVC(edgesToFill:Bool = false) {
        self.transitionVC.edgesToVC(self, edgesToFill: edgesToFill)
        self.configTransitionVC(edgesToFill: edgesToFill)
    }
    // MARK: -
    func configSegmentedControlToVC(segmentedControl:SegmentedControl, _ closure:((ChildListViewModelType,Int)->())? = nil) {
        _ = segmentedControl.rx.value.asObservable().subscribe(onNext: {[unowned self] (index) in
            if index < self.transitionVC.listArray.count {
                self.transitionVC.selectedIndex = index
            }
        })
        updateTransitionChildVC(segmentedControl: segmentedControl,closure)
    }
    func updateTransitionChildVC(segmentedControl:SegmentedControl?, _ closure:((ChildListViewModelType,Int)->())? = nil) {
        self.transitionVC.listArray = {
            var array = [ScrollVCProtocol]()
            /// ZJaDe: 根据segmentedControl的item个数来创建子控制器，如果segmentedControl为空则只创建1次
            for index in 0..<(segmentedControl?.modelArray.count ?? 1) {
                let (viewModel,listVC) = self.addChildListVC(edgesToFill: nil, index: index)
                closure?(viewModel,index)
                array.append(listVC)
            }
            return array
        }()
    }
}