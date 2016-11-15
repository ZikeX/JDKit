//
//  JDTableModel.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/26.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDTableModel:JDListModel {
    /// ZJaDe: contentView的inset
    var spaceEdges = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    var itemsSpace:CGFloat = 8
    var lineColor = Color.separatorLine
    var lineHeight:CGFloat = 1
    /// ZJaDe: 分割线inset
    var separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    // MARK: - cell高度
    /// ZJaDe: cellContentHeight 不包含分割线的高度,但是包括edges的高度
    var cellContentHeight:CGFloat?
    var needCalculateCellHeight = true
    
    private var cellContentHeightIsInvalidated = false
    func invalidateCellHeight() {
        cellContentHeightIsInvalidated = true
    }
    func makeCellHeightCanUse() {
        cellContentHeightIsInvalidated = false
    }
    var cellHeightIsCanUse: Bool {
        return cellContentHeightIsInvalidated == false && cellContentHeight != nil
    }
    var isNibCell = false
    // MARK: -
    var cellSelectedBackgroundView = UIView()
    var cellSelectedBackgroundColor:UIColor? = Color.selectedCell
    // MARK: -
}
