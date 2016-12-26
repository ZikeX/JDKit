//
//  PageProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

protocol PageProtocol:AddChildScrollProtocol {
    associatedtype PageVCType:PageViewController
    var pageVC:PageVCType {get}
    
    // MARK: - 调用下面方法可以添加transitionVC到本控制器
    func addPageVC(edgesToFill:Bool)
    // MARK: - 子协议实现
    func willAddPageVC(_ edgesToFill: Bool)
    func didAddPageVC(_ edgesToFill: Bool)
    // MARK: - 创建pageVC之后的一些设置
    func configPageVC(_ edgesToFill: Bool)
    // MARK: - 创建子控制器
    func updateChildVC()
    func resetChildVC()
    // MARK: 创建每个子控制器后的配置
    func configChildVC(index:Int,childVC:ChildScrollVCType)
    // MARK: - 订阅scrollView滚动
    func subscribeWhenScroll()
    func updateWhenScroll()
    func calculateScale(length:CGFloat) -> CGFloat?
}
private var PageVCKey:UInt8 = 0
extension PageProtocol where Self:BaseViewController {
    var pageVC:PageViewController {
        return associatedObject(&PageVCKey, createIfNeed:{ PageViewController() })
    }
    func addPageVC(edgesToFill:Bool = false) {
        willAddPageVC(edgesToFill)
        _ = self.addChildScrollVC(edgesToFill: edgesToFill)
        didAddPageVC(edgesToFill)
        
        self.configPageVC(edgesToFill)
        self.resetChildVC()
    }
    func createMainVC() -> PageVCType {
        return self.pageVC
    }
    func willAddPageVC(_ edgesToFill: Bool) {
        
    }
    func didAddPageVC(_ edgesToFill: Bool) {
        
    }
    func configPageVC(_ edgesToFill: Bool) {
        
    }
    // MARK: -
    func updateChildVC() {
        self.pageVC.clearAllChildVC()
        self.pageVC.createScrollVCClosure = {[unowned self] (index) in
            let childVC = self.createScrollVC(index: index)
            childVC.index = index
            self.configChildVC(index: index, childVC: childVC)
            return childVC
        }
        self.pageVC.loadChildVC()
    }
    func resetChildVC() {
        self.pageVC.scrollVCCount = 1
        self.updateChildVC()
    }
    func configChildVC(index:Int,childVC:ChildScrollVCType) {
        
    }
    // MARK: -
    func subscribeWhenScroll() {
        let pageVC:PageViewController = self.pageVC
        pageVC.rx.observe(Int.self, "currentScrollVC").subscribe (onNext: {[unowned self] (event) in
            self.pageVC.currentScrollView?.rx.observe(CGPoint.self, "contentOffset")
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
        let scrollView = self.pageVC.currentScrollView!
        
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
