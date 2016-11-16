//
//  NavigationItemProtocol.swift
//  JDNavigationController
//
//  Created by 茶古电子商务 on 16/9/22.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol NavigationItemProtocol {
    var navBarIsHidden:Bool {get set}
    var navBarTintColor:UIColor {get set}
    var navTintColor:UIColor {get set}
    var navBarAlpha:CGFloat {get set}
    var navBarShadowColor:UIColor? {get set}
    func configInitAboutNavBar()
}
extension NavigationItemProtocol where Self:UIViewController {
    
    fileprivate func configNavBar(_ navBar:UINavigationBar?,animated:Bool) {
        guard self.navigationController is BaseNavigationController else {
            //限制navigationController必须为JDNavigationController
            return
        }
        guard self.parent is BaseNavigationController || self.parent is BaseTabBarController else {
            return
        }
        guard let navBar = navBar else {
            return
        }
        UIView.animate(withDuration:animated ? 0.25 : 0.0, animations: {
            self.botttomLineColor(navigationBar: navBar, color: self.navBarShadowColor)
            self.changeTintColor(navBar: navBar)
            self.changeBarTintColor(navBar: navBar)
            let alpha = self.navBarIsHidden ? 0 : self.navBarAlpha
            self.changeAlpha(alpha: alpha, navBar: navBar)
        }) { (finished) in
            self.changeIsHidden(navVC: self.navigationController)
        }
    }
}
extension UIViewController {
    func configInitAboutNavBar() {
        let subject1 = self.rx.sentMessage(#selector(viewWillAppear))
        let subject2 = self.rx.sentMessage(#selector(viewDidAppear))
        _ = Observable.of(subject1,subject2).merge().subscribe { (event) in
            self.configNavBar(self.navigationController?.navigationBar, animated: true)
        }
    }
}

private var jd_navBarIsHiddenKey: UInt8 = 0
private var jd_navBarTintColorKey: UInt8 = 0
private var jd_navTintColorKey: UInt8 = 0
private var jd_navBarAlphaKey: UInt8 = 0
private var jd_navBarShadowColorKey: UInt8 = 0

extension UIViewController:NavigationItemProtocol {
    
    var navBarIsHidden:Bool {
        get {
            let _navBarIsHidden = objc_getAssociatedObject(self, &jd_navBarIsHiddenKey) as? Bool
            return _navBarIsHidden ?? false
        }
        set {
            objc_setAssociatedObject(self, &jd_navBarIsHiddenKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.changeIsHidden(navVC: self.navigationController)
        }
    }
    var navBarTintColor: UIColor {
        get {
            let _navBarTintColor = objc_getAssociatedObject(self, &jd_navBarTintColorKey) as? UIColor
            return _navBarTintColor ?? Color.white
        }
        set {
            objc_setAssociatedObject(self, &jd_navBarTintColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.changeBarTintColor(navBar: self.navBar)
        }
    }
    var navTintColor: UIColor {
        get {
            let _navTintColor = objc_getAssociatedObject(self, &jd_navTintColorKey) as? UIColor
            return _navTintColor ?? Color.black
        }
        set {
            objc_setAssociatedObject(self, &jd_navTintColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.changeTintColor(navBar: self.navBar)
        }
    }
    var navBarAlpha: CGFloat {
        get {
            let _navBarAlpha = objc_getAssociatedObject(self, &jd_navBarAlphaKey) as? CGFloat
            return _navBarAlpha ?? 1.0
        }
        set {
            objc_setAssociatedObject(self, &jd_navBarAlphaKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            changeAlpha(alpha: newValue, navBar: self.navBar)
        }
    }
    var navBarShadowColor: UIColor? {
        get {
            let _navBarShadowColor = objc_getAssociatedObject(self, &jd_navBarShadowColorKey) as? UIColor
            return _navBarShadowColor ?? Color.viewBackground
        }
        set {
            objc_setAssociatedObject(self, &jd_navBarShadowColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.botttomLineColor(navigationBar: self.navBar, color: newValue)
        }
    }
}
extension UIViewController {
    //如果isTranslucent 设置为true,设置了setBackgroundImage，barTintColor无效
    //但是isTranslucent 设置为false时，nav的子控制器的大小又不是整个屏幕了
    //如果加上navigationBar.barStyle = .black 就能解决问题
    fileprivate func botttomLineColor(navigationBar:UINavigationBar?,color:UIColor?) {
        navigationBar?.barStyle = .black
        navigationBar?.isTranslucent = true
        navigationBar?.shadowImage = color != self.navBarTintColor ? UIImage.imageWithColor(color) : nil
        setNavBarBackgroundImage()
    }
    fileprivate func changeAlpha(alpha:CGFloat,navBar:UINavigationBar?) {
        navBar?.setValue(alpha, forKeyPath: "_backgroundView.alpha")
    }
    fileprivate func changeTintColor(navBar:UINavigationBar?) {
        navBar?.tintColor = self.navTintColor
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName:self.navTintColor]
    }
    fileprivate func changeBarTintColor(navBar:UINavigationBar?) {
        navBar?.barTintColor = self.navBarTintColor
        setNavBarBackgroundImage()
    }
    private func setNavBarBackgroundImage() {
        if navBar?.shadowImage != nil {
            navBar?.setBackgroundImage(UIImage.imageWithColor(self.navBarTintColor), for: .default)
        }else {
            navBar?.setBackgroundImage(nil, for: .default)
        }
    }
    fileprivate func changeIsHidden(navVC:UINavigationController?) {
        navVC?.isNavigationBarHidden = self.navBarIsHidden
    }
}
