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

protocol ScrollProperty {
    var scrollView:UIScrollView {get}
}

class TransitionViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    var headerView:UIView? {
        willSet {
            listenIndexOrHeaderViewWillChanged()
        }
        didSet {
            listenIndexOrHeaderViewDidChanged(indexChanged: false)
            configHeaderView()
        }
    }
    fileprivate var headerViewHeight:CGFloat? = nil {
        willSet {
            if let scrollView = self.currentScrollView,
                let headerViewHeight = headerViewHeight {
                self.offsetY = scrollView.contentOffset.y + headerViewHeight
                scrollView.contentInset.top -= headerViewHeight
                logDebug("headerViewHeight-contentInsetTop--】】\(scrollView.contentInset.top)")
            }
        }
        didSet {
            if let scrollView = self.currentScrollView,
                let headerViewHeight = headerViewHeight {
                scrollView.contentInset.top += headerViewHeight
                logDebug("headerViewHeight+contentInsetTop++】】\(scrollView.contentInset.top)")
                changeContentOffsetY(scrollView: scrollView, y: self.offsetY - headerViewHeight)
            }
        }
    }
    
    var mainView = UIView()
    var titleView:UIView? {
        didSet {
            titleViewChanged()
        }
    }
    //var layoutToViewTop = false
    var bottomView:UIView? {
        didSet {
            bottomViewChanged()
        }
    }
    var listArray = [ScrollProperty]()  {
        didSet {
            transition()
        }
    }

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
    /// ZJaDe: 内部存储下标
    fileprivate var currentIndex:Int? = nil
    
    var currentScrollView:UIScrollView? {
        if currentIndex != nil && currentIndex! < self.listArray.count {
            return self.listArray[currentIndex!].scrollView
        }
        return nil
    }
    fileprivate var offsetY:CGFloat = 0
    //MARK: ----
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        updateMainView()
        configHeaderView()
    }
}
extension TransitionViewController {
    func titleViewChanged() {
        if let titleView = titleView,titleView.superview == nil {
            self.view.addSubview(titleView)
            titleView.snp.makeConstraints({ (maker) in
                maker.left.centerX.top.equalToSuperview()
            })
        }
        updateMainView()
    }
    func bottomViewChanged() {
        if let bottomView = bottomView,bottomView.superview == nil {
            self.view.addSubview(bottomView)
            bottomView.snp.makeConstraints({ (maker) in
                maker.left.centerX.bottom.equalToSuperview()
            })
        }
        updateMainView()
    }
    func updateMainView() {
        self.view.addSubview(mainView)
        mainView.snp.remakeConstraints({ (maker) in
            maker.left.centerX.equalToSuperview()
            /// ZJaDe: titleView
            if let titleView = self.titleView {
                maker.topSpace(titleView)
            }else {
//                if self.layoutToViewTop {
                    maker.topSpace()
//                }else {
//                    maker.topSpaceToVC(self)
//                }
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
    /// ZJaDe: 当headerView将要设置的时候，或者currentIndex将要变化的时候调用
    func listenIndexOrHeaderViewWillChanged() {
        if let scrollView = self.currentScrollView,
            let headerView = self.headerView {
            self.offsetY = scrollView.contentOffset.y + headerView.height
            scrollView.contentInset.top -= headerView.height
            logDebug("HeaderViewWillChanged-contentInsetTop--】】\(scrollView.contentInset.top)")
        }
    }
    /// ZJaDe: 当headerView已经设置的时候，或者currentIndex已经变化的时候调用
    func listenIndexOrHeaderViewDidChanged(indexChanged:Bool) {
        if let scrollView = self.currentScrollView,
            let headerView = self.headerView {
            if headerView.superview != scrollView {
                scrollView.addSubview(headerView)
                headerView.snp.makeConstraints { (maker) in
                    maker.left.centerX.equalTo(self.view)
                    maker.bottomSpace(scrollView)
                }
            }
            
            scrollView.contentInset.top += headerView.height
            logDebug("HeaderViewDidChanged-contentInsetTop--】】\(scrollView.contentInset.top)")
            if indexChanged {
                changeContentOffsetY(scrollView: scrollView, y: self.offsetY - headerView.height)
            }else {
                scrollView.contentOffset.y = -scrollView.contentInset.top
                logDebug("HeaderViewDidChanged-contentOffsetY--】】\(scrollView.contentOffset.y)")
            }
        }
    }
    func changeContentOffsetY(scrollView:UIScrollView,y:CGFloat) {
        var bag = DisposeBag()
        if scrollView.size == CGSize() {
            scrollView.rx.observe(CGRect.self, "bounds").subscribe({ (event) in
                if scrollView.size != CGSize() {
                    scrollView.contentOffset.y = y
                    logDebug("scrollView--contentOffsetY--】】\(scrollView.contentOffset.y)")
                    bag = DisposeBag()
                }
            }).addDisposableTo(bag)
        }else {
            scrollView.contentOffset.y = y
            logDebug("scrollView-contentOffsetY--】】\(scrollView.contentOffset.y)")
        }
    }
    func configHeaderView() {
        //headerView高度变化时
        headerView?.rx.observe(CGRect.self, "bounds").subscribe({ (event) in
            if self.headerViewHeight != self.headerView!.height {
                self.headerViewHeight = self.headerView!.height
            }
        }).addDisposableTo(disposeBag)
    }
}
extension TransitionViewController {
    /// ZJaDe: 切换控制器
    func transition(toIndex:Int? = nil) {
        guard self.listArray.count > 0 else {
            return
        }
        let toIndex = toIndex ?? self.currentIndex ?? 0
        guard toIndex<self.listArray.count else {
            logError("下标越界")
            return
        }
        /// ZJaDe: 下标没变，已经有子控制器加载时
        if self.currentIndex == toIndex && hasChildVC {
            return
        }
        // MARK: - oldCurrentIndex
        let oldCurrentIndex = self.currentIndex
        listenIndexOrHeaderViewWillChanged()
        
        self.currentIndex = toIndex
        
        /// ZJaDe: 没有子控制器加载或者第一次加载时
        if !hasChildVC || oldCurrentIndex == nil {
            self.addSubListViewWithIndex(index: toIndex)
        }else {
            /// ZJaDe: 下标变化，已经有子控制器加载时
            if let fromVC = self.listArray[oldCurrentIndex!] as? UIViewController,
                let toVC = self.listArray[toIndex] as? UIViewController {
                
                self.addChildViewController(fromVC)
                self.addChildViewController(toVC)
                
                self.transition(from: fromVC, to: toVC, duration: 0, options: .transitionCrossDissolve, animations: {
                    self.addSubListViewWithIndex(index: toIndex)
                }, completion: { (finish) in
                })
            }
        }
        listenIndexOrHeaderViewDidChanged(indexChanged: true)
    }
    var hasChildVC:Bool {
        return self.mainView.subviews.count > 0
    }
    func addSubListViewWithIndex(index:Int) {
        if let listVC = self.listArray[index] as? UIViewController {
            if listVC.parent == nil {
                self.addChildViewController(listVC)
                listVC.didMove(toParentViewController: self)
            }
            self.mainView.removeAllSubviews()
            self.mainView.addSubview(listVC.view)
            listVC.view.edgesToView()
        }
    }
}
