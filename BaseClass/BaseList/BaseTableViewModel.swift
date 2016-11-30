//
//  BaseTableViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseTableViewModel: JDTableViewModel {
    func createBaseTableView() -> BaseTableView {
        let tableView = BaseTableView(viewModel: self)
        self.resetInit()
        return tableView
    }
}
