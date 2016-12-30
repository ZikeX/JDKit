//
//  HUD.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import MBProgressHUD

class HUD {
    fileprivate(set) var MBhud:_ProgressHUD?
    
    static fileprivate func createMBHUD(_ view:UIView) -> _ProgressHUD {
        let MBhud = _ProgressHUD(view: view)
        view.addSubview(MBhud)
        MBhud.removeFromSuperViewOnHide = true
        return MBhud
    }
    
    func show() {
        self.MBhud!.show(animated: true)
    }
    func hide(closure:(()->())? = nil) {
        self.MBhud!.hide(closure: closure)
    }
    static func hide(for view:UIView, isAll:Bool = false) {
        for subView in view.subviews.reversed() {
            if let hud = subView as? _ProgressHUD {
                hud.removeFromSuperViewOnHide = true;
                hud.hide()
                if !isAll {
                    break
                }
            }
        }
    }
}
extension HUD {
    @discardableResult
    static func showMessage(_ text:String, to view:UIView? = nil) -> HUD {
        let hud = HUD()
        Async.main {
            if let view = view ?? jd.visibleVC()?.view {
                let MBhud = createMBHUD(view)
                MBhud.label.text = text
                MBhud.show(animated: true)
                hud.MBhud = MBhud
            }
        }
        return hud
    }
}
extension HUD {
    private static func show(_ text:String, icon:String, delay:TimeInterval, to view:UIView?) {
        Async.main {
            let view = view ?? jd.rootWindow
            
            let MBhud = createMBHUD(view)
            MBhud.canInteractive = true
            MBhud.hideWhenTap()
            MBhud.detailsLabel.text = text
            MBhud.customView = ImageView(image: UIImage(named: "MBProgressHUD.bundle/" + icon))
            MBhud.mode = .customView
            
            MBhud.show(animated: true)
            MBhud.hide(delay: delay)
        }
    }
    static func showSuccess(_ text:String, delay:TimeInterval = 0.7, to view:UIView? = nil) {
        self.show(text, icon: "success", delay:delay, to: view)
    }
    static func showError(_ text:String, delay:TimeInterval = 0.7, to view:UIView? = nil) {
        self.show(text, icon: "error", delay:delay, to: view)
    }
}
extension HUD {
    private static var promptArray = [_ProgressHUD]()
    
    static func showPrompt(_ text:String, to view:UIView? = nil) {
        Async.main {
            let view = view ?? jd.rootWindow
            
            let prompt = createMBHUD(view)
            prompt.canInteractive = true
            prompt.hideWhenTap()
            prompt.detailsLabel.text = text
            prompt.mode = .text
            prompt.margin = 10
            prompt.offset.y = {
                var offsetY = (50 - promptArray.count * 50).toCGFloat
                if offsetY < -150 {
                    offsetY = -150
                }
                return offsetY
            }()
            prompt.bezelView.style = .solidColor
            prompt.bezelView.color = Color.black
            prompt.bezelView.addBorder(color:Color.white)
            prompt.detailsLabel.textColor = Color.white
            prompt.show(animated: true)
            promptArray.append(prompt)
            prompt.completionBlock = {[unowned prompt] in
                if let index = promptArray.index(of: prompt) {
                    promptArray.remove(at: index)
                }
            }
            prompt.hide(delay: 0.7,falling:true)
        }
    }
}
extension HUD {
    func custom(_ closure:(MBBackgroundView)->UIView) -> HUD {
        let custom = HUD.createMBHUD(jd.rootWindow)
        custom.margin = 0
        custom.mode = .customView
        custom.bezelView.style = .solidColor
        custom.bezelView.color = Color.clear
        custom.backgroundView.style = .solidColor
        custom.backgroundView.color = Color.black.alpha(0.75)
        custom.customView = closure(custom.backgroundView)
        
        self.MBhud = custom
        return self
    }
    static func showCustom(_ closure:@escaping (MBBackgroundView)->UIView) -> HUD {
        let hud = HUD()
        Async.main {
            hud.custom(closure).show()
        }
        return hud
    }
    func hideNoAnimate() {
        self.MBhud?.hide(animated: false)
    }
    func showNoAnimate() {
        self.MBhud?.show(animated: false)
    }
}
