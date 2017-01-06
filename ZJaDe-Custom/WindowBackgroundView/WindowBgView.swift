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
        _ = self.bgView.rx.whenTouch({[unowned self] (view) in
            self.hide()
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
}

extension WindowBgView {
    func show(resetToHide:Bool = true, in viewCon:UIViewController? = nil) {
        if resetToHide {
            self.hideAnimateClosure?()
        }
        let viewCon = viewCon ?? jd.currentNavC
        viewCon.windowBgArrs.append(self)
        viewCon.showFirstBgView()
    }
    /**
     func mustHide() {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        let navC = jd.currentNavC
        if let index = navC.windowBgArrs.index(of: self) {
            navC.windowBgArrs.remove(at: index)
        }
    }
     */
    static func hide() {
        jd.currentNavC.hideFirstBgView()
    }
    func hide(in viewCon:UIViewController? = nil) {
        let viewCon = self.parent ?? jd.currentNavC
        viewCon.hideFirstBgView()
    }
}
private var WindowBgArrKey:UInt8 = 0
extension UIViewController {
    // MARK: -
    fileprivate func showFirstBgView() {
        if let windowBg = windowBgArrs.first,!windowBg.isShowing {
            self.addChildViewController(windowBg)
            self.view.addSubview(windowBg.view)
            windowBg.isShowing = true
            UIView.spring(duration: 0.35) {
                windowBg.view.alpha = 1
            }
            windowBg.showAnimateClosure?()
        }
    }
    func hideFirstBgView() {
        if let bgView = windowBgArrs.first {
            UIView.animate(withDuration: 0.35, animations: {
                bgView.hideAnimateClosure?()
                bgView.view.alpha = 0
            }) { (finish) in
                bgView.view.removeFromSuperview()
                bgView.removeFromParentViewController()
                if self.windowBgArrs.count > 0 {
                    self.windowBgArrs.removeFirst()
                    self.showFirstBgView()
                }
            }
        }
    }
    fileprivate var windowBgArrs:[WindowBgView] {
        get {
            return associatedObject(&WindowBgArrKey) {[WindowBgView]()}
        }
        set {
            setAssociatedObject(&WindowBgArrKey, newValue)
        }
    }
}
