//
//  HeaderViewProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol HeaderViewProtocol:TransitionProtocol {
    associatedtype HeaderViewType:BaseScrollHeaderView
    var headerView:HeaderViewType {get}
}
extension HeaderViewProtocol where Self:BaseViewController {
    func whenAddTransitionVC(_ edgesToFill: Bool) {
        self.installHeaderView(self.headerView)
    }
}
protocol HeaderViewWithSegmentProtocol:SegmentedControlProtocol {
    associatedtype HeaderViewType:BaseScrollHeaderView
    var headerView:HeaderViewType {get}
}
extension HeaderViewWithSegmentProtocol where Self:BaseViewController {
    func whenAddTransitionVC(_ edgesToFill: Bool) {
        _ = segmentedControl.rx.value.asObservable().subscribe(onNext: {[unowned self] (index) in
            if index < self.transitionVC.scrollVCCount {
                self.transitionVC.selectedIndex = index
            }
        })
        self.installHeaderView(self.headerView)
    }
    var segmentedControl: SegmentedControl {
        return self.headerView.segmentedControl
    }
}
