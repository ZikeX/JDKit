//
//  JDTableViewController.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTableViewController: JDListViewController {
    lazy private(set) var tableView:JDTableView = JDTableView(viewModel: self.viewModel)
    
    var viewModel:JDTableViewModel {
        didSet {
            viewModel.listVC = self
            self.tableView.viewModel = viewModel
            self.viewModel.resetInit()
        }
    }
    init(viewModel:JDTableViewModel) {
        self.viewModel = viewModel
        super.init()
        viewModel.listVC = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("暂时不支持xib")
    }
    override func loadView() {
        self.view = self.tableView
    }
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.resetInit()
    }

}
