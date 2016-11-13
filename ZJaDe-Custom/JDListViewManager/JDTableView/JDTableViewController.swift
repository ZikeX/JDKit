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
    
    private(set) var style:UITableViewStyle = .plain
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override init(style: UITableViewStyle = .plain) {
        self.style = style
        super.init(style: style)
        configInit()
    }
    override func loadView() {
        self.tableView = JDTableView(style: style)
    }
    func configInit() {
        
    }
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.loadLocalSectionModels()
    }
    // MARK: -
    open func configTableView() {
        
    }
    func getLocalSectionModels() -> [(JDTableViewSection, [JDTableViewModel])]? {
        return nil
    }
}
