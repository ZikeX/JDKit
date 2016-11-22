//
//  BaseTableViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseTableViewModel: JDTableViewModel {
    var index:Int!
    
    var listTitle:String? {
        didSet {
            self.listVC?.title = self.listTitle
        }
    }
    func createBaseTableView() -> BaseTableView {
        let tableView = BaseTableView(viewModel: self)
        self.resetInit()
        return tableView
    }
    func createBaseListVC() -> BaseTableViewController {
        let listVC = BaseTableViewController(viewModel: self)
        listVC.title = self.listTitle
        listVC.index = index
        return listVC
    }
}
