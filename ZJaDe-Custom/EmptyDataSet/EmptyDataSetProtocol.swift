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
}
extension UIScrollView:EmptyDataSetProtocol {
    var itemsCount: Int {
        return self.subviews.count
    }
}
extension UITableView {
    override var itemsCount: Int {
        var items = 0
        guard let dataSource = self.dataSource else {
            return items
        }
        for sectionIndex in 0..<(dataSource.numberOfSections?(in: self) ?? 0) {
            items += dataSource.tableView(self, numberOfRowsInSection: sectionIndex)
        }
        return items
    }
}
extension UICollectionView {
    override var itemsCount: Int {
        var items = 0
        guard let dataSource = self.dataSource else {
            return items
        }
        for sectionIndex in 0..<(dataSource.numberOfSections?(in: self) ?? 0) {
            items += dataSource.collectionView(self, numberOfItemsInSection: sectionIndex)
        }
        return items
    }
}
