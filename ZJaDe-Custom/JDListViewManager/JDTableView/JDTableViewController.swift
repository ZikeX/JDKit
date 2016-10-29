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
    
    var jdStyle:UITableViewStyle = .plain
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override init(style: UITableViewStyle = .plain) {
        jdStyle = style
        super.init(style: style)
        configInit()
    }
    override func loadView() {
        self.tableView = JDTableView(style: jdStyle)
    }
    func configInit() {
        
    }
    
}
