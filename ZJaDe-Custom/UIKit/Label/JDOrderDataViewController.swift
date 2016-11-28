//
//  JDOrderDataViewController.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDOrderDataViewController: BaseViewController {
    lazy var headerView:JDOrderDataHeaderView = JDOrderDataHeaderView()
    lazy var selectView:JDOrderDataDateSelectView = JDOrderDataDateSelectView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBarItem { (navItem) in
            navItem.title = "订单数据"
            navItem.rightBarButtonItem = UIBarButtonItem.image(R.image.ic_menu()!, { (item) in
                self.selectView.show()
            })
        }
        self.addTransitionVCWithHeaderView()
    }
}
extension JDOrderDataViewController:HeaderViewProtocol {
    func createListViewModel(index: Int) -> JDOrderDataListViewModel {
        let viewModel = JDOrderDataListViewModel()
        viewModel.listStyle = .grouped
        return viewModel
    }
}
