//
//  WindowBgView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/1.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

enum AlertAnimationStyle {
    case noAnimation, topToBottom, bottomToTop, leftToRight, rightToLeft
}

class WindowBgView: UIViewController {
    fileprivate var isShowing:Bool = false
    init() {
        super.init(nibName:nil, bundle:nil)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - closure
    fileprivate var showAnimateClosure:(()->())?
    fileprivate var hideAnimateClosure:(()->())?
    // MARK: -
    fileprivate var bgView = BackgroundView()
    func configInit() {
        self.view.frame = CGRect(x: 0, y: 0, width: jd.screenWidth, height: jd.screenHeight)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.bgView)
        self.bgView.edgesToView()
        _ = self.bgView.rx.whenTouch({ (view) in
            WindowBgView.hide()
        })
        self.view.alpha = 0
    }
}
extension WindowBgView {
    @discardableResult
    func configShowAnimate(animated:Bool = true,_ closure:@escaping ()->()) -> WindowBgView {
        self.showAnimateClosure = {
            UIView.spring(duration:animated ? 0.35 : 0) {
                closure()
            }
        }
        return self
    }
    @discardableResult
    func configHideAnimate(_ closure:@escaping ()->()) -> WindowBgView {
        self.hideAnimateClosure = closure
        return self
    }
    @discardableResult
    func toHideState() -> WindowBgView {
        self.hideAnimateClosure?()
        return self
    }
}
private var windowBgViews = [WindowBgView]()
extension WindowBgView {
    func show(tohide:Bool = true) {
        if tohide {
            toHideState()
        }
        windowBgViews.append(self)
        jd.keyWindow.showFirstBgView()
    }
    func mustHide() {
        self.view.removeFromSuperview()
        if let index = windowBgViews.index(of: self) {
            windowBgViews.remove(at: index)
        }
    }
    static func hide() {
        jd.keyWindow.hideFirstBgView()
    }
}
extension UIWindow {
    // MARK: -
    fileprivate func showFirstBgView() {
        if let bgView = windowBgViews.first,!bgView.isShowing {
            self.addSubview(bgView.view)
            bgView.isShowing = true
            UIView.spring(duration: 0.35) {
                bgView.view.alpha = 1
            }
            bgView.showAnimateClosure?()
        }
    }
    func hideFirstBgView() {
        if let bgView = windowBgViews.first {
            UIView.animate(withDuration: 0.35, animations: {
                bgView.hideAnimateClosure?()
                bgView.view.alpha = 0
            }) { (finish) in
                bgView.view.removeFromSuperview()
                if windowBgViews.count > 0 {
                    windowBgViews.removeFirst()
                    self.showFirstBgView()
                }
            }
        }
    }

}
