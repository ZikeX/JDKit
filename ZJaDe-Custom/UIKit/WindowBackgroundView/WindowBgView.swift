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
    var isShowing:Bool = false
    init() {
        super.init(nibName:nil, bundle:nil)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configInit() {
        self.view.frame = CGRect(x: 0, y: 0, width: jd.screenWidth, height: jd.screenHeight)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.darkBlack.withAlphaComponent(0.4)
        _ = self.view.rx.whenTouch({ (view) in
            jd.keyWindow.hideFirstBgView()
        })
        self.view.alpha = 0
    }
    
    var showClosure:(()->())?
    var hideClosure:(()->())?
}
extension WindowBgView {
    func show() {
        let window = jd.keyWindow
        window.bgViews.append(self)
        window.showFirstBgView()
    }
    func hide() {
        let window = jd.keyWindow
        self.view.removeFromSuperview()
        if let index = window.bgViews.index(of: self) {
            window.bgViews.remove(at: index)
        }
    }
}
private var WindowBgViewKey:UInt8 = 0
extension UIWindow {
    var bgViews:[WindowBgView] {
        get {
            let bgViews:[WindowBgView]
            if let existing = objc_getAssociatedObject(self, &WindowBgViewKey) as? [WindowBgView] {
                bgViews = existing
            }else {
                bgViews = [WindowBgView]()
                self.bgViews = bgViews
            }
            return bgViews
        }
        set {
            objc_setAssociatedObject(self, &WindowBgViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    // MARK: -
    fileprivate func showFirstBgView() {
        if let bgView = self.bgViews.first,!bgView.isShowing {
            self.addSubview(bgView.view)
            bgView.isShowing = true
            UIView.spring(duration: 0.35) {
                bgView.view.alpha = 1
                bgView.showClosure?()
            }
        }
    }
    func hideFirstBgView() {
        if let bgView = self.bgViews.first {
            UIView.animate(withDuration: 0.35, animations: {
                bgView.view.alpha = 0
                bgView.hideClosure?()
            }) { (finish) in
                bgView.view.removeFromSuperview()
                self.bgViews.removeFirst()
                self.showFirstBgView()
            }
        }
    }

}
