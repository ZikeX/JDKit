//
//  JDTableView.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTableView: UITableView {
    var viewModel:JDTableViewModel {
        didSet {
            viewModel.tableView = self
            viewModel.configDataSource()
            viewModel.configDelegate()
        }
    }
    
    // MARK: -
    init(viewModel:JDTableViewModel) {
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
