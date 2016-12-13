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
    func willAddTransitionVC(_ edgesToFill: Bool) {
        self.transitionVC.defaultHeaderHeight = self.headerView.defaultHeight
        self.installHeaderView(self.headerView)
    }
}
protocol HeaderViewWithSegmentProtocol:SegmentProtocol,HeaderViewProtocol {
    
}
extension HeaderViewWithSegmentProtocol where Self:BaseViewController {
    var segmentedControl: SegmentedControl {
        return self.headerView.segmentedControl
    }
}
