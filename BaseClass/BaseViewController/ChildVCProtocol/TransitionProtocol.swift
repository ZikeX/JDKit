//
//  TransitionProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

protocol TransitionProtocol:AddChildScrollProtocol {
    var transitionVC:TransitionViewController {get set}
    // MARK: - 调用下面方法可以添加transitionVC到本控制器
    func addTransitionVC(edgesToFill:Bool)
    // MARK: - addTransitionVC 子协议实现
    func willAddTransitionVC(_ edgesToFill:Bool)
    func didAddTransitionVC(_ edgesToFill:Bool)
    // MARK: - 创建transitionVC之后的一些设置
    func configTransitionVC(_ edgesToFill: Bool)
    // MARK: - 创建子控制器
    func updateChildVC()
    // MARK: - 订阅scrollView滚动
    func subscribeWhenScroll()
    func updateWhenScroll()
    func calculateScale(length:CGFloat) -> CGFloat?
}
extension TransitionProtocol where Self:BaseViewController {
    func addTransitionVC(edgesToFill:Bool = false) {
        self.willAddTransitionVC(edgesToFill)
        self.transitionVC.edgesToVC(self, edgesToFill: edgesToFill)
        self.didAddTransitionVC(edgesToFill)
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
    func willAddTransitionVC(_ edgesToFill:Bool) {
        
    }
    func didAddTransitionVC(_ edgesToFill:Bool) {
        
    }
    
    func subscribeWhenScroll() {
        self.transitionVC.rx.observe(Int.self, "selectedIndex").subscribe (onNext: {[unowned self] (event) in
            self.transitionVC.currentScrollView?.rx.observe(CGPoint.self, "contentOffset")
                .subscribe(onNext: {[unowned self] (event) in
                self.updateWhenScroll()
            }).addDisposableTo((self as BaseViewController).disposeBag)
        }).addDisposableTo((self as BaseViewController).disposeBag)
    }
    func updateWhenScroll() {
        
    }
    func calculateScale(length:CGFloat) -> CGFloat? {
        guard length > 0 else {
            return nil
        }
        let scrollView = self.transitionVC.currentScrollView!
        
        var scale = (scrollView.contentInset.top + scrollView.contentOffset.y) / length
        if scale < 0 {scale = 0}
        if scale > 1 {scale = 1}
        
        guard self.navBarAlpha != scale else {
            return nil
        }
        self.navBarAlpha = scale
        
        return scale
    }
}
