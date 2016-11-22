//
//  AddChildListProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
protocol AddChildListProtocol:class {
    associatedtype ChildListViewModelType:BaseTableViewModel
    func createListViewModel(index:Int) -> ChildListViewModelType
    
    var firstChildVC:ChildListViewModelType? {get}
    func childVC(index:Int) -> ChildListViewModelType?
    
    func addChildListVC(edgesToFill:Bool?,index:Int) -> (ChildListViewModelType,BaseTableViewController)
    func configListVC(viewModel:ChildListViewModelType,listVC:BaseTableViewController,index:Int)
}
extension AddChildListProtocol where Self:BaseViewController {
    var firstChildVC:ChildListViewModelType? {
        return self.childVC(index: 0)
    }
    func childVC(index:Int) -> ChildListViewModelType? {
        for childVC in self.childViewControllers {
            if let childVC = childVC as? ChildListViewModelType,childVC.index == index {
                return childVC
            }
        }
        return nil
    }
    // MARK: -
    @discardableResult
    func addChildListVC(edgesToFill:Bool? = false,index:Int = 0) -> (ChildListViewModelType,BaseTableViewController) {
        let viewModel = createListViewModel(index: index)
        viewModel.index = index
        let listVC = viewModel.createBaseListVC()
        if edgesToFill != nil {
            listVC.edgesToVC(self, edgesToFill: edgesToFill!)
        }
        self.configListVC(viewModel: viewModel, listVC: listVC, index: index)
        return (viewModel,listVC)
    }
    func configListVC(viewModel:ChildListViewModelType,listVC:BaseTableViewController,index:Int) {
        
    }
}
