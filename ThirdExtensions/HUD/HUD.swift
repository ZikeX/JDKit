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
    class _MBProgressHUD: MBProgressHUD {
        var canInteractive:Bool = false
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            if canInteractive {
                if self.bezelView.frame.contains(point) {
                    return self.bezelView
                }else {
                    return nil
                }
            }else {
                return super.hitTest(point, with: event)
            }
        }
        func hideWhenTap() {
            _ = self.bezelView.rx.whenTouch({[unowned self] (bezelView) in
                self.hide(animated: true)
            })
        }
    }
    fileprivate var MBhud:_MBProgressHUD?
    
    static func createMBHUD(_ view:UIView) -> _MBProgressHUD {
        let MBhud = _MBProgressHUD(view: view)
        view.addSubview(MBhud)
        MBhud.removeFromSuperViewOnHide = true
        return MBhud
    }
    @discardableResult
    static func showMessage(_ text:String, toView:UIView? = nil) -> HUD {
        let hud = HUD()
        Async.main {
            if let view = toView ?? jd.visibleVC()?.view {
                let MBhud = createMBHUD(view)
                MBhud.label.text = text
                MBhud.show(animated: true)
                hud.MBhud = MBhud                
            }
        }
        return hud
    }
    func hide() {
        Async.main {
            self.MBhud?.hide(animated: true)
        }
    }
    static func hide(_ forView:UIView) {
        Async.main {
            _MBProgressHUD.hide(for: forView, animated: true)
        }
    }
}
extension HUD {
    private static func show(_ text:String, icon:String, toView:UIView?) {
        Async.main {
            let view = toView ?? jd.keyWindow
            
            let MBhud = createMBHUD(view)
            MBhud.canInteractive = true
            MBhud.hideWhenTap()
            MBhud.label.text = text
            MBhud.customView = ImageView(image: UIImage(named: "MBProgressHUD.bundle/" + icon))
            MBhud.mode = .customView
            
            MBhud.show(animated: true)
            MBhud.hide(animated: true, afterDelay: 0.7)
        }
    }
    static func showSuccess(_ text:String, toView:UIView? = nil) {
        self.show(text, icon: "success", toView: toView)
    }
    static func showError(_ text:String, toView:UIView? = nil) {
        self.show(text, icon: "error", toView: toView)
    }
}
extension HUD {
    private static var promptArray = [_MBProgressHUD]()
    
    static func showPrompt(_ text:String, toView:UIView? = nil) {
        Async.main {
            let view = toView ?? jd.keyWindow
            
            let prompt = createMBHUD(view)
            prompt.canInteractive = true
            prompt.hideWhenTap()
            prompt.label.text = text
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
            prompt.label.textColor = Color.white
            prompt.show(animated: true)
            promptArray.append(prompt)
            prompt.completionBlock = {[unowned prompt] in
                if let index = promptArray.index(of: prompt) {
                    promptArray.remove(at: index)
                }
            }
            SwiftTimer.asyncAfter(seconds: 0.5, after: {
                UIView.animate(withDuration: 1.5, animations: {
                    prompt.bezelView.alpha = 0
                    prompt.offset.y = 200
                    prompt.setNeedsLayout()
                    prompt.layoutIfNeeded()
                }, completion: { (finished) in
                    prompt.hide(animated: false)
                })
            })
        }
    }
}
