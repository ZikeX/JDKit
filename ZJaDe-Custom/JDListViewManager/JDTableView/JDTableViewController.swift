//
//  JDTableViewController.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTableViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    var jdTableView:JDTableView {
        return self.tableView as! JDTableView
    }
    let viewModel:JDTableViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("暂时不支持xib")
    }
    init(viewModel:JDTableViewModel) {
        self.viewModel = viewModel
        super.init(style: viewModel.listStyle)
        viewModel.listVC = self
        configInit()
    }
    override func loadView() {
        self.tableView = JDTableView(viewModel: self.viewModel)
    }
    func configInit() {
        
    }
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.resetInit()
    }
}
