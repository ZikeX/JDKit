//
//  PageViewController.swift
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
class PageViewController: UIViewController {
    
    lazy var pageVC:UIPageViewController = {
        let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageVC.edgesToVC(self, edgesToFill: true)
        pageVC.dataSource = self
        pageVC.delegate = self
        return pageVC
    }()
    
    var scrollVCCount:Int = 0
    var createScrollVCClosure:((Int)->(ScrollVCProtocol))!

    /// ZJaDe: 内部存储
    fileprivate lazy var allScrollVC = [Int:ScrollVCProtocol]()
    var currentIndex:Int = 0
    var currentIndexChanged = PublishSubject<Int>()
    var currentScrollVC:UIViewController? {
        willSet {
            self.willChangeValue(forKey: "currentScrollVC")
        }
        didSet {
            self.didChangeValue(forKey: "currentScrollVC")
        }
    }
    var currentScrollView:UIScrollView? {
        return self.currentScrollVC?.view as? UIScrollView
    }
    //MARK: ----
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
}
extension PageViewController:UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.getIndex(self.currentIndex - 1) else {
            return nil
        }
        return self.getScrollVC(index: index) as? UIViewController
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.getIndex(self.currentIndex + 1) else {
            return nil
        }
        return self.getScrollVC(index: index) as? UIViewController
    }
    fileprivate func getIndex(_ index:Int) -> Int? {
        if index < 0 {
            return index + self.scrollVCCount
        }else if index >= self.scrollVCCount {
            return index - self.scrollVCCount
        }else {
            return index
        }
    }
}
extension PageViewController:UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentVC = self.pageVC.viewControllers?.first {
            self.allScrollVC.enumerated().forEach({ (offset,element) in
                if let value = element.value as? UIViewController, value == currentVC {
                    self.currentIndex = element.key
                    self.currentScrollVC = currentVC
                    self.currentIndexChanged.onNext(self.currentIndex)
                }
            })
            
        }
    }
}
extension PageViewController {
    func loadChildVC() {
        var index = self.currentIndex
        if index >= self.scrollVCCount {
            index = self.scrollVCCount - 1
        }
        self.scroll(to: index)
    }
    /// ZJaDe: 切换控制器
    func scroll(to index: Int) {
        guard self.scrollVCCount > 0 else {
            return
        }
        let toIndex = self.getIndex(index) ?? 0
        
        let toVC = self.getScrollVC(index: toIndex) as! UIViewController
        /// ZJaDe: scroll没变
        if self.currentScrollVC == toVC {
            return
        }
        self.pageVC.setViewControllers([toVC], direction: .forward, animated: false) { (finished) in
            if finished {
                self.currentIndex = toIndex
                self.currentScrollVC = toVC
            }
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
    func clearAllChildVC() {
        self.allScrollVC.forEach { (key: Int, value: ScrollVCProtocol) in
            (value as! UIViewController).removeFromParentViewController()
        }
        self.allScrollVC.removeAll()
    }
}
