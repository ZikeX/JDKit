//
//  AssetGridViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class AssetGridViewController: BaseViewController {
    
    var maxImageCount:Int = 1
    
    lazy var viewModel = AssetGridViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configNavBarItem { (navItem) in
            navItem.title = "选择图片"
            navItem.leftBarButtonItem = self.cacelButton.barButtonItem()
            navItem.rightBarButtonItem = self.doneButton.barButtonItem()
        }
        self.doneButton.rx.touchUpInside {[unowned self] (button) in
            self.cacelVC()
        }
    }
    
}
extension AssetGridViewController:AddChildListProtocol {
    func createListViewModel(index: Int) -> AssetGridViewModel {
        return self.viewModel
    }
}

