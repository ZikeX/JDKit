//
//  ScreeningViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class ScreeningViewController: BaseViewController {
    
    lazy var titleView:ScreeningView = ScreeningView()
    lazy var mainView = UIView()
    lazy var bgBlackView:BackgroundView = BackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPageVC()
        configTitleView()
        configBlackView()
    }
}
extension ScreeningViewController {
    func configBlackView() {
        self.view.addSubview(self.bgBlackView)
        self.bgBlackView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(self.mainVC.view)
        }
        self.bgBlackView.isHidden = true
        self.bgBlackView.alpha = 0
        self.bgBlackView.rx.whenTouch {[unowned self] (view) in
            self.titleView.self.clearSelectedItem()
        }.addDisposableTo(disposeBag)
    }
}
// MARK: - ScreeningView
extension ScreeningViewController {
    func configTitleView() {
        self.titleView.contentVerticalPriority(UILayoutPriorityRequired)
        self.titleView.configSelectItemChanged {[unowned self] (index,item) in
            if let item = item {
                self.showList(index:index!,item:item)
            }else {
                self.hideList()
            }
        }
    }
}
extension ScreeningViewController {
    func showList(index:Int,item:Button) {
        self.bgBlackView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.bgBlackView.alpha = 1
        }
    }
    func hideList() {
        UIView.animate(withDuration: 0.5, animations: {
            self.bgBlackView.alpha = 0
        }, completion: { (finished) in
            self.bgBlackView.isHidden = true
        })
    }
}
extension ScreeningViewController:ListPageProtocol {

    func createListViewModel(index: Int) -> ListViewModel {
        fatalError("子类实现")
    }
}
