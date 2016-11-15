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
    var viewModel:JDTableViewModel! {
        didSet {
            viewModel.tableView = self
            viewModel.configDataSource()
            viewModel.configDelegate()
        }
    }
    
    // MARK: -
    override init(frame: CGRect = CGRect(), style: UITableViewStyle = .plain) {
        super.init(frame: frame, style: style)
        self.configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configInit()
    }
    func configInit() {
        self.separatorStyle = .none
    }
}
