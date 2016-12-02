//
//  AddChildListProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol AddChildListProtocol:class {
    associatedtype ChildListViewModelType:JDListViewModel
    typealias ChildScrollVCType = JDScorllViewController
    // MARK: - 实现下面两个方法中的一个，来创建控制器
    func createScrollVC(index:Int) -> ChildScrollVCType?
    func createListViewModel(index:Int) -> ChildListViewModelType
    // MARK: - 创建控制器之后的一些设置
    func configListVC(viewModel:ChildListViewModelType?,listVC:ChildScrollVCType,index:Int)
    // MARK: - 获取子控制器
    var firstChildVC:ChildScrollVCType? {get}
    func childVC(index:Int) -> ChildScrollVCType?
    // MARK: - 调用该方法可添加子控制器到本控制器中
    func addChildListVC(edgesToFill:Bool?,index:Int) -> (ChildListViewModelType?,ChildScrollVCType)
}
extension AddChildListProtocol where Self:BaseViewController {
    // MARK: -
    func createScrollVC(index:Int) -> ChildScrollVCType? {
        return nil
    }
    func configListVC(viewModel:ChildListViewModelType?,listVC:ChildScrollVCType,index:Int) {
        
    }
    // MARK: -
    var firstChildVC:ChildScrollVCType? {
        return self.childVC(index: 0)
    }
    func childVC(index:Int) -> ChildScrollVCType? {
        for childVC in self.childViewControllers {
            if let childVC = childVC as? ChildScrollVCType,childVC.index == index {
                return childVC
            }
        }
        return nil
    }
    // MARK: -
    @discardableResult
    func addChildListVC(edgesToFill:Bool? = false,index:Int = 0) -> (ChildListViewModelType?,ChildScrollVCType) {
        var listVC:ChildScrollVCType
        var viewModel:ChildListViewModelType?
        if let existing = createScrollVC(index: index) {
            existing.index = index
            listVC = existing
        }else {
            viewModel = createListViewModel(index: index)
            viewModel!.index = index
            listVC = viewModel!.createBaseListVC()
        }
        if edgesToFill != nil {
            listVC.edgesToVC(self, edgesToFill: edgesToFill!)
        }
        self.configListVC(viewModel: viewModel, listVC: listVC, index: index)
        return (viewModel,listVC)
    }
}
