//
//  JDTableViewModel.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/26.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDTableViewModel:JDModel {
    /// ZJaDe: contentView的inset
    var spaceEdges = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    var itemsSpace:CGFloat = 8
    var lineColor = Color.separatorLine
    var lineHeight:CGFloat = 1
    /// ZJaDe: 分割线inset
    var separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    /// ZJaDe: cellContentHeight 不包含分割线的高度
    var cellContentHeight:CGFloat?
    var autoAdjustHeight = true
    
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
    
    var cellSelectedBackgroundView = UIView()
    var cellSelectedBackgroundColor:UIColor? = Color.selectedCell
    var cellBackgroundColor:UIColor?
    
    //高度计算出来之后，最终的约束
    var theEndLayoutClosure:((CGFloat) -> ())?
}