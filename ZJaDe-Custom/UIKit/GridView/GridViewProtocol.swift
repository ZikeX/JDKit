//
//  GridViewProtocol.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/11/1.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol GridViewProtocol {
    associatedtype GridViewItemType:UIView
    associatedtype GridViewItemDataType
    var gridView:GridView<GridViewItemType> {get set}
    var gridViewItemsData:[GridViewItemDataType] {get set}
    func createGridView() -> GridView<GridViewItemType>
}
