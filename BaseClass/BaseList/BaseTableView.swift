//
//  BaseTableView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseTableView: JDTableView {
    
    
}
class BaseTableViewController: JDTableViewController,ScrollProperty {
    
    var scrollView: UIScrollView {
        return self.tableView
    }
    override func configInit() {
        super.configInit()
        self.jdTableView.backgroundColor = Color.viewBackground
        configInitAboutNavBar()
        configInitAboutViewState()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
    }
    final private func configTableView() {
        self.jdTableView.dataArray.value = getSectionModels()
    }
    func getSectionModels() -> [SectionModel<JDTableViewSection,JDTableViewModel>] {
        fatalError("子类实现")
    }
}
