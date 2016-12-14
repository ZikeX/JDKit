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
    
    fileprivate func configNavBar(animated:Bool) {
        guard self.navC is BaseNavigationController else {
            //限制navigationController必须为JDNavigationController
            return
        }
        guard !(self is BaseTabBarController) && (self.parent is BaseNavigationController || self.parent is BaseTabBarController) else {
            return
        }
        UIView.animate(withDuration:animated ? 0.25 : 0.0, animations: {
            self.botttomLineColor(color: self.navBarShadowColor)
            self.changeTintColor()
            self.changeBarTintColor()
            let alpha = self.navBarIsHidden ? 0 : self.navBarAlpha
            self.changeAlpha(alpha: alpha)
        }) { (finished) in
            self.changeIsHidden()
        }
    }
}
extension UIViewController {
    func configInitAboutNavBar() {
        self.configNavBar(animated: true)
    }
}

private var jd_navBarItemKey: UInt8 = 0
extension UIViewController:NavigationItemProtocol {
    struct NavigationItemStruct {
        var barIsHidden:Bool = false
        var barTintColor:UIColor = Color.white
        var tintColor:UIColor = Color.navBarTintColor
        var alpha:CGFloat = 1.0
        var titleAlpha:CGFloat = 1.0
        var shadowColor: UIColor? = Color.viewBackground
    }
    private var navItemStruct:NavigationItemStruct {
        get {
            let _navItemStruct:NavigationItemStruct
            if let existing = objc_getAssociatedObject(self, &jd_navBarItemKey) as? NavigationItemStruct {
                _navItemStruct = existing
            }else {
                _navItemStruct = NavigationItemStruct()
                self.navItemStruct = _navItemStruct
            }
            return _navItemStruct
        }
        set {
            objc_setAssociatedObject(self, &jd_navBarItemKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func checkVCType() -> Bool {
        return !(self is UITabBarController) && (self.parent is BaseNavigationController || self.parent is BaseTabBarController)
    }
    var navBarIsHidden:Bool {
        get {
            return self.navItemStruct.barIsHidden
        }
        set {
            self.navItemStruct.barIsHidden = newValue
            guard checkVCType() else {
                return
            }
            self.changeIsHidden()
        }
    }
    var navBarTintColor: UIColor {
        get {
            return self.navItemStruct.barTintColor
        }
        set {
            self.navItemStruct.barTintColor = newValue
            guard checkVCType() else {
                return
            }
            self.changeBarTintColor()
        }
    }
    var navTintColor: UIColor {
        get {
            return self.navItemStruct.tintColor
        }
        set {
            self.navItemStruct.tintColor = newValue
            guard checkVCType() else {
                return
            }
            self.changeTintColor()
        }
    }
    var navBarAlpha: CGFloat {
        get {
            return self.navItemStruct.alpha
        }
        set {
            self.navItemStruct.alpha = newValue
            guard checkVCType() else {
                return
            }
            changeAlpha(alpha: newValue)
        }
    }
    var navBarTitleAlpha: CGFloat {
        get {
            return self.navItemStruct.titleAlpha
        }
        set {
            self.navItemStruct.titleAlpha = newValue
            guard checkVCType() else {
                return
            }
            changeTitleAlpha(alpha: newValue)
        }
    }
    var navBarShadowColor: UIColor? {
        get {
            return self.navItemStruct.shadowColor
        }
        set {
            self.navItemStruct.shadowColor = newValue
            guard checkVCType() else {
                return
            }
            self.botttomLineColor(color: newValue)
        }
    }
}
extension UIViewController {
    //如果isTranslucent 设置为true,设置了setBackgroundImage，barTintColor无效
    //但是isTranslucent 设置为false时，nav的子控制器的大小又不是整个屏幕了
    //如果加上navigationBar.barStyle = .black 就能解决问题
    fileprivate func botttomLineColor(color:UIColor?) {
        self.navBar?.barStyle = .black
        self.navBar?.isTranslucent = true
        self.navBar?.shadowImage = color != self.navBarTintColor ? UIImage.imageWithColor(color) : nil
        setNavBarBackgroundImage()
    }
    fileprivate func changeAlpha(alpha:CGFloat) {
        self.navBar?.setValue(alpha, forKeyPath: "_backgroundView.alpha")
    }
    fileprivate func changeTitleAlpha(alpha:CGFloat) {
        self.navBar?.titleTextAttributes = [NSForegroundColorAttributeName:self.navTintColor.alpha(alpha),NSFontAttributeName:Font.p24]
    }
    fileprivate func changeTintColor() {
        self.navBar?.tintColor = self.navTintColor
        self.changeTitleAlpha(alpha: self.navBarTitleAlpha)
        if let titleView = self.navBar?.value(forKey: "_titleView") as? UIView {
            let scale:CGFloat = self.navTintColor == Color.white ? 1.0 : 0.0
            titleView.addShadowInWhiteView(scale: scale)
        }
    }
    fileprivate func changeBarTintColor() {
        self.navBar?.barTintColor = self.navBarTintColor
        setNavBarBackgroundImage()
    }
    fileprivate func changeIsHidden() {
        self.navC?.isNavigationBarHidden = self.navBarIsHidden
    }
    
    private func setNavBarBackgroundImage() {
        if navBar?.shadowImage != nil {
            navBar?.setBackgroundImage(UIImage.imageWithColor(self.navBarTintColor), for: .default)
        }else {
            navBar?.setBackgroundImage(nil, for: .default)
        }
    }
}
