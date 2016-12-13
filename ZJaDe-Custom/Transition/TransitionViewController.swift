//
//  TransitionViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol ScrollVCProtocol {
    var scrollView:UIScrollView {get}
}
class TransitionMainView: UIView {
}
class TransitionViewController: UIViewController {
    var defaultHeaderHeight:CGFloat?
    var headerView:UIView? {
        didSet {
            addHeaderViewToScrollView()
            bindingHeaderViewHeight()
        }
    }
    
    var mainView = TransitionMainView()
    weak var titleView:UIView? {
        didSet {
            titleViewChanged()
        }
    }
    weak var bottomView:UIView? {
        didSet {
            bottomViewChanged()
        }
    }
    var scrollVCCount:Int = 0
    var createScrollVCClosure:((Int)->(ScrollVCProtocol))!

    var selectedIndex:Int {
        get {
            return self.currentIndex ?? 0
        }
        set {
            self.willChangeValue(forKey: "selectedIndex")
            transition(toIndex: newValue)
            self.didChangeValue(forKey: "selectedIndex")
        }
    }
    /// ZJaDe: 内部存储
    fileprivate lazy var allScrollVC = [Int:ScrollVCProtocol]()
    fileprivate var currentIndex:Int? = nil
    fileprivate var currentScrollVC:UIViewController?
    fileprivate(set) var currentScrollView:UIScrollView?
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
        self.automaticallyAdjustsScrollViewInsets = false
        updateMainView()
        bindingHeaderViewHeight()
    }
}
extension TransitionViewController {
    fileprivate func titleViewChanged() {
        if let titleView = titleView {
            if titleView.superview == nil {
                self.view.addSubview(titleView)
            }
            titleView.snp.makeConstraints({ (maker) in
                maker.left.centerX.top.equalToSuperview()
            })
        }
        updateMainView()
    }
    fileprivate func bottomViewChanged() {
        if let bottomView = bottomView {
            if bottomView.superview == nil {
                self.view.addSubview(bottomView)
            }
            bottomView.snp.makeConstraints({ (maker) in
                maker.left.centerX.bottom.equalToSuperview()
            })
        }
        updateMainView()
    }
    fileprivate func updateMainView() {
        self.view.insertSubview(mainView, at: 0)
        mainView.snp.remakeConstraints({ (maker) in
            maker.left.centerX.equalToSuperview()
            /// ZJaDe: titleView
            if let titleView = self.titleView {
                maker.topSpace(titleView)
            }else {
                maker.top.equalToSuperview()
            }
            /// ZJaDe: bottomView
            if let bottomView = self.bottomView {
                maker.bottomSpace(bottomView)
            }else {
                maker.bottomSpaceToVC(self)
            }
        })
    }
}
extension TransitionViewController {
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
    fileprivate func bindingHeaderViewHeight() {
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
extension TransitionViewController {
    /// ZJaDe: 切换控制器
    func transition(toIndex:Int? = nil) {
        guard self.scrollVCCount > 0 else {
            return
        }
        let toIndex = toIndex ?? self.currentIndex ?? 0
        guard toIndex < self.scrollVCCount else {
            logError("下标越界")
            return
        }
        let toVC = self.getScrollVC(index: toIndex) as! UIViewController
        self.currentIndex = toIndex
        /// ZJaDe: scroll没变，已经有子控制器加载时
        if self.currentScrollVC == toVC {
            return
        }
        logDebug("currentScrollView-->willSet")
        willUpdateContentOffsetAndInset()
        if self.currentScrollVC == nil {
            /// ZJaDe: 没有子控制器加载或者第一次加载时
            self.addSubListViewWithIndex(index: toIndex)
        }else {
//            let fromVC = self.currentScrollVC!
            /// ZJaDe: 下标变化，已经有子控制器加载时
            self.addSubListViewWithIndex(index: toIndex)
        }
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
            self.mainView.removeAllSubviews()
            self.mainView.addSubview(scrollVC.view)
            scrollVC.view.edgesToView()
            self.currentScrollVC = scrollVC
            self.currentScrollView = scrollVC.view as! UIScrollView?
        }
    }
    // MARK: - getList
    func getScrollVC(index:Int) -> ScrollVCProtocol {
        let scrollVC:ScrollVCProtocol
        if let existing = self.allScrollVC[index] {
            scrollVC = existing
        }else {
            scrollVC = self.createScrollVCClosure(index)
            self.allScrollVC[index] = scrollVC
        }
        return scrollVC
    }
    func getList(index:Int) -> UIScrollView {
        return self.getScrollVC(index: index).scrollView
    }
    func clearAllChildVC() {
        self.allScrollVC.forEach { (key: Int, value: ScrollVCProtocol) in
            (value as! UIViewController).removeFromParentViewController()
        }
        self.allScrollVC.removeAll()
    }
}
