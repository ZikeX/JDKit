//
//  HeaderViewProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol HeaderViewProtocol:PageProtocol {
    associatedtype HeaderViewType:BaseScrollHeaderView
    var headerView:HeaderViewType {get}
}
private var PageVCKey:UInt8 = 0
extension HeaderViewProtocol where Self:BaseViewController {
    var pageVC:HeaderPageController {
        return associatedObject(&PageVCKey, createIfNeed:{ HeaderPageController() })
    }
    func willAddPageVC(_ edgesToFill: Bool) {
        let pageVC:HeaderPageController = self.pageVC as! HeaderPageController
        pageVC.defaultHeaderHeight = self.headerView.defaultHeight
        pageVC.headerView = self.headerView
    }
}
protocol HeaderViewWithSegmentProtocol:SegmentProtocol,HeaderViewProtocol {
    
}
extension HeaderViewWithSegmentProtocol where Self:BaseViewController {
    var segmentedControl: SegmentedControl {
        return self.headerView.segmentedControl
    }
}
