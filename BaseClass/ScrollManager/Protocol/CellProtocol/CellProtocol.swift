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
    // MARK: - item初始化
    func configItemInit()
    // MARK: - 做一些数据初始化
    func itemDidInit()
    // MARK: - item加载完毕，初始化数据及约束
    func itemDidLoad(_ element: ModelType)
    // MARK: - item将要显示，做动画，element绑定item
    func itemWillAppear(_ element: ModelType)
    // MARK: item根据element绑定数据
    func configItemWithElement(_ element: ModelType)
    // MARK: item设置数据后,如果需要在这里更新约束
    func itemUpdateConstraints(_ element: ModelType)
    // MARK: - item已经消失,element解绑item
    func itemDidDisappear(_ element: ModelType?)
}


