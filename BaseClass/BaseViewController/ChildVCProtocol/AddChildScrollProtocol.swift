//
//  AddChildScrollProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol AddChildScrollProtocol:class {
    associatedtype ChildScrollVCType:JDScrollViewController
    // MARK: - 实现下面方法创建控制器
    func createScrollVC(index:Int) -> ChildScrollVCType
    // MARK: - 调用该方法可添加子控制器到本控制器中
    func addChildScrollVC(edgesToFill:Bool?,index:Int) -> ChildScrollVCType
    // MARK: - 添加子控制器后的一些设置
    func configChildScrollVC(scrollVC:ChildScrollVCType,index:Int)
}
extension AddChildScrollProtocol where Self:BaseViewController {
    // MARK: -
    @discardableResult
    func addChildScrollVC(edgesToFill:Bool? = false,index:Int = 0) -> ChildScrollVCType {
        let listVC:ChildScrollVCType = createScrollVC(index: index)
        listVC.index = index
        if edgesToFill != nil {
            listVC.edgesToVC(self, edgesToFill: edgesToFill!)
        }
        configChildScrollVC(scrollVC: listVC, index: index)
        return listVC
    }
    func configChildScrollVC(scrollVC:ChildScrollVCType,index:Int) {
        
    }
}
