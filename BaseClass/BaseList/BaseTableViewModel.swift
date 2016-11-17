//
//  BaseTableViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseTableViewModel: JDTableViewModel {
    
    var listTitle:String? {
        didSet {
            self.listVC?.title = self.listTitle
        }
    }
    func createBaseTableView() -> BaseTableView {
        let tableView = BaseTableView(viewModel: self)
        self.configTableView(tableView)
        self.loadLocalSectionModels()
        return tableView
    }
    func createBaseListVC() -> BaseTableViewController {
        let listVC = BaseTableViewController(viewModel: self)
        listVC.title = self.listTitle
        return listVC
    }
}
