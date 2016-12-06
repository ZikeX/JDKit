//
//  AddChildScrollProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol AddChildScrollProtocol:class {
    associatedtype ChildListViewModelType:JDListViewModel
    associatedtype ChildScrollVCType:JDScrollViewController
    // MARK: - 实现下面两个方法中的一个，来创建控制器
    func createScrollVC(index:Int) -> ChildScrollVCType?
    func createListViewModel(index:Int) -> ChildListViewModelType
    // MARK: - 创建控制器之后的一些设置
    func configScrollVC(viewModel:ChildListViewModelType?,listVC:ChildScrollVCType,index:Int)
    // MARK: - 获取子控制器
    var firstChildVC:ChildScrollVCType? {get}
    func childVC(index:Int) -> ChildScrollVCType?
    // MARK: - 调用该方法可添加子控制器到本控制器中
    func addChildScrollVC(edgesToFill:Bool?,index:Int) -> (ChildListViewModelType?,ChildScrollVCType)
}
extension AddChildScrollProtocol where Self:BaseViewController {
    // MARK: -
    func createScrollVC(index:Int) -> JDScrollViewController? {
        return nil
    }
    func createListViewModel(index:Int) -> JDListViewModel {
        fatalError("scrollVC返回nil,这里必须实现这个方法")
    }
    func configScrollVC(viewModel:ChildListViewModelType?,listVC:ChildScrollVCType,index:Int) {
        
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
    func addChildScrollVC(edgesToFill:Bool? = false,index:Int = 0) -> (ChildListViewModelType?,ChildScrollVCType) {
        var listVC:ChildScrollVCType
        var viewModel:ChildListViewModelType?
        if let existing = createScrollVC(index: index) {
            existing.index = index
            listVC = existing
        }else {
            viewModel = createListViewModel(index: index)
            viewModel!.index = index
            listVC = viewModel!.createBaseListVC() as! Self.ChildScrollVCType
        }
        if edgesToFill != nil {
            listVC.edgesToVC(self, edgesToFill: edgesToFill!)
        }
        self.configScrollVC(viewModel: viewModel, listVC: listVC, index: index)
        return (viewModel,listVC)
    }
}