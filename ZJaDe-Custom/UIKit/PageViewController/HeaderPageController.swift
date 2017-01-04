//
//  HeaderPageController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class HeaderPageController: PageViewController {
    
    var defaultHeaderHeight:CGFloat?
    var headerView:UIView? {
        didSet {
            addHeaderViewToScrollView()
            headerViewBinding()
        }
    }
    
    fileprivate var headerViewHeight:CGFloat? = nil {
        willSet {
            if self.headerViewHeight != newValue {
                logDebug("headerViewHeight-->willSet")
                willUpdateContentOffsetAndInset()
            }
        }
        didSet {
            if self.headerViewHeight != oldValue {
                logDebug("headerViewHeight-->didSet")
                updateContentOffsetAndInset()
            }
        }
    }
    
    fileprivate var offsetY:CGFloat = 0
    //MARK: ----
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerViewBinding()
    }
}
extension HeaderPageController {
    fileprivate func addHeaderViewToScrollView() {
        if let scrollView = self.currentScrollView,
            let headerView = self.headerView {
            if headerView.superview != scrollView {
                scrollView.addSubview(headerView)
                headerView.snp.makeConstraints { (maker) in
                    maker.left.centerX.equalTo(self.view)
                    maker.bottomSpace(scrollView).priority(990)
                }
            }
        }
    }
    /// ZJaDe: 当headerView将要改变或高度将要变化的时候，或者currentScroll将要变化的时候调用
    fileprivate func willUpdateContentOffsetAndInset() {
        if let headerViewHeight = headerViewHeight,
            let scrollView = self.currentScrollView {
            self.offsetY = scrollView.contentOffset.y + headerViewHeight
            scrollView.contentInset.top -= headerViewHeight
            logDebug("-----contentInsetTop--】】\(scrollView.contentInset.top)")
        }
    }
    /// ZJaDe: 当headerView已经改变或高度已经变化的时候，或者currentScroll已经变化的时候调用
    fileprivate func updateContentOffsetAndInset() {
        if let headerViewHeight = headerViewHeight,
            let scrollView = self.currentScrollView {
            scrollView.contentInset.top += headerViewHeight
            logDebug("-----contentInsetTop++】】\(scrollView.contentInset.top)")
            changeContentOffsetY(scrollView: scrollView, y: self.offsetY - headerViewHeight)
        }
    }
    fileprivate func changeContentOffsetY(scrollView:UIScrollView,y:CGFloat) {
        scrollView.contentOffset.y = y
        logDebug("scrollView-contentOffsetY】】\(scrollView.contentOffset.y)")
    }
    fileprivate func headerViewBinding() {
        if self.defaultHeaderHeight == nil {
            //headerViewHeight改变时
            headerView?.rx.observe(CGRect.self, "bounds", retainSelf:false).subscribe(onNext: {[unowned self] (event) in
                self.headerViewHeight = self.defaultHeaderHeight ?? self.headerView!.height
            }).addDisposableTo(headerView!.disposeBag)
        }else {
            self.updateHeaderViewHeight()
        }
    }
    func updateHeaderViewHeight() {
        self.headerViewHeight = self.defaultHeaderHeight!
    }
}
extension HeaderPageController {
    /// ZJaDe: 切换控制器
    override func scroll(to index: Int) {
        guard self.scrollVCCount > 0 else {
            return
        }
        guard index >= 0, index < self.scrollVCCount else {
            logError("下标越界")
            return
        }
        let toVC = self.getScrollVC(index: index) as! UIViewController
        /// ZJaDe: scroll没变，已经有子控制器加载时
        if self.currentScrollVC == toVC {
            return
        }
        logDebug("currentScrollView-->willSet")
        willUpdateContentOffsetAndInset()
        
        self.addSubListViewWithIndex(index: index)
        
        logDebug("currentScrollView-->didSet")
        addHeaderViewToScrollView()
        updateContentOffsetAndInset()
    }
    func addSubListViewWithIndex(index:Int) {
        if let scrollVC = self.getScrollVC(index: index) as? UIViewController {
            if scrollVC.parent == nil {
                self.addChildViewController(scrollVC)
                scrollVC.didMove(toParentViewController: self)
            }
            self.currentScrollVC?.view.removeFromSuperview()
            self.currentScrollVC?.removeFromParentViewController()
            self.view.addSubview(scrollVC.view)
            scrollVC.view.edgesToView()
            self.currentIndex = index
            self.currentScrollVC = scrollVC
        }
    }
}
