//
//  TransitionProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

protocol TransitionProtocol:AddChildScrollProtocol {
    var transitionVC:TransitionViewController {get set}
    // MARK: - 调用下面方法可以添加transitionVC到本控制器
    func addTransitionVC(edgesToFill:Bool)
    // MARK: - addTransitionVC 子协议实现
    func whenAddTransitionVC(_ edgesToFill:Bool)
    // MARK: - 创建transitionVC之后的一些设置
    func configTransitionVC(_ edgesToFill: Bool)
    // MARK: - 创建子控制器
    func updateChildVC()
}
extension TransitionProtocol where Self:BaseViewController {
    func addTransitionVC(edgesToFill:Bool = false) {
        self.transitionVC.edgesToVC(self, edgesToFill: edgesToFill)
        self.whenAddTransitionVC(edgesToFill)
        self.configTransitionVC(edgesToFill)
        self.updateChildVC()
    }
    func updateChildVC() {
        self.transitionVC.clearAllChildVC()
        self.transitionVC.scrollVCCount = 1
        self.transitionVC.createScrollVCClosure = {[unowned self] (index) in
            let listVC = self.addChildScrollVC(edgesToFill: nil, index: index)
            return listVC
        }
        self.transitionVC.transition()
    }
    
    func installHeaderView(_ headerView:UIView) {
        self.transitionVC.headerView = headerView
    }
    func installTitleView(_ titleView:UIView) {
        self.transitionVC.titleView = titleView
    }
    func installBottomView(_ bottomView:UIView) {
        self.transitionVC.bottomView = bottomView
    }
    func configTransitionVC(_ edgesToFill: Bool) {
        
    }
    func whenAddTransitionVC(_ edgesToFill:Bool) {
        
    }
}
