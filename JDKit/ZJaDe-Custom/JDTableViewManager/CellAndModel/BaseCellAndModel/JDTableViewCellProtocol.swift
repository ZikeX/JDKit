//
//  JDTableViewCellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/7.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol JDTableViewCellProtocol {
    /** 控件初始化 添加子控件 */
    func configCellInit(_ cell:JDTableViewCell)
    /** 根据element初始化约束 */
    func cellDidLoad(_ cell:JDTableViewCell,element:JDElementModel)
    /** 动画，此时element绑定cell */
    func cellWillAppear(_ cell:JDTableViewCell,element:JDElementModel)
    /** cell根据element绑定数据 */
    func configCellWithElement(_ cell:JDTableViewCell,element:JDElementModel)
    /** 此时element解绑cell */
    func cellDidDisappear(_ cell:JDTableViewCell,element:JDElementModel)
}
