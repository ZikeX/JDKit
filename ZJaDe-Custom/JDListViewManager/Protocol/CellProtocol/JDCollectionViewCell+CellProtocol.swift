//
//  JDCollectionViewCell+CellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension JDCollectionViewCell : CellProtocol {
    typealias ModelType = JDCollectionViewModel
    
    // MARK: - cell初始化
    func configCellInit() {
        
    }
    // MARK: - 做一些数据初始化
    func cellDidInit() {
        
    }
    // MARK: - cell加载完毕，初始化数据及约束
    func cellDidLoad(_ element: JDCollectionViewModel) {
        
    }
    // MARK: - cell将要显示，做动画，element绑定cell
    final func cellWillAppear(_ element: JDCollectionViewModel) {
        configCellWithElement(element)
        cellUpdateConstraints(element)
    }
    // MARK: cell根据element绑定数据
    func configCellWithElement(_ element: JDCollectionViewModel) {
        
    }
    // MARK: cell设置数据后,如果需要在这里更新约束
    func cellUpdateConstraints(_ element: JDCollectionViewModel) {
        
    }
    // MARK: - cell已经消失,element解绑cell
    func cellDidDisappear(_ element: JDCollectionViewModel) {
        
    }
}
