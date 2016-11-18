//
//  EmptyDataSetProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/18.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
protocol EmptyDataSetProtocol {
    var emptyDataSetView:EmptyDataSetView {get}
    var itemsCount:Int {get}
    func reloadEmptyDataSet(_ state:EmptyViewState)
}
private var emptyDataSetViewKey:UInt8 = 0
extension EmptyDataSetProtocol where Self:UIScrollView {
    var emptyDataSetView:EmptyDataSetView {
        var view:EmptyDataSetView
        if let existing = objc_getAssociatedObject(self, &emptyDataSetViewKey) as? EmptyDataSetView {
            view = existing
        }else {
            view = EmptyDataSetView()
            objc_setAssociatedObject(self, &emptyDataSetViewKey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return view
    }
    func reloadEmptyDataSet(_ state:EmptyViewState) {
        let emptyView = self.emptyDataSetView
        if emptyView.superview == nil {
            self.insertSubview(emptyView, at: 0)
        }
        self.emptyDataSetView.reloadData(state)
    }
}
extension UIScrollView:EmptyDataSetProtocol {
    var itemsCount: Int {
        return self.subviews.count
    }
}
extension UITableView {
    override var itemsCount: Int {
        var items = 0
        for sectionIndex in 0..<self.numberOfSections {
            items += self.numberOfRows(inSection: sectionIndex)
        }
        return items
    }
}
extension UICollectionView {
    override var itemsCount: Int {
        var items = 0
        for sectionIndex in 0..<self.numberOfSections {
            items += self.numberOfItems(inSection: sectionIndex)
        }
        return items
    }
}
