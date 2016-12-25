//
//  TableView.swift
//  TableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class TableView: UITableView {
    var viewModel:TableViewModel {
        didSet {
            viewModel.tableView = self
            viewModel.configDataSource()
            viewModel.configDelegate()
        }
    }
    
    // MARK: -
    init(viewModel:TableViewModel) {
        self.viewModel = viewModel
        super.init(frame: CGRect(), style: viewModel.listStyle)
        viewModel.tableView = self
        viewModel.configDataSource()
        viewModel.configDelegate()
        self.configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("暂时不支持xib")
    }
    func configInit() {
        self.separatorStyle = .none
        self.backgroundColor = Color.clear
    }
}
