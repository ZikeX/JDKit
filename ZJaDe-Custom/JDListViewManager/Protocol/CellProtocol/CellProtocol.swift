//
//  CellManagerProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/25.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

protocol CellProtocol {
    var enabled:Bool {get set}
    associatedtype ModelType
    // MARK: - cell初始化
    func configCellInit()
    // MARK: - 做一些数据初始化
    func cellDidInit()
    // MARK: - cell加载完毕，初始化数据及约束
    func cellDidLoad(_ element: ModelType)
    // MARK: - cell将要显示，做动画，element绑定cell
    func cellWillAppear(_ element: ModelType)
    // MARK: cell根据element绑定数据
    func configCellWithElement(_ element: ModelType)
    // MARK: cell设置数据后,如果需要在这里更新约束
    func cellUpdateConstraints(_ element: ModelType)
    // MARK: - cell已经消失,element解绑cell
    func cellDidDisappear(_ element: ModelType?)
}


