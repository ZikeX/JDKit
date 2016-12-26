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
    class _ProgressHUD: MBProgressHUD {
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
        func hideWhenTap(falling:Bool = false) {
            _ = self.bezelView.rx.whenTouch({[unowned self] (bezelView) in
                self.hide(falling:falling)
            })
        }
        func hide(delay:TimeInterval = 0, duration:TimeInterval = 1.5,falling:Bool = false) {
            SwiftTimer.asyncAfter(seconds: delay) {
                self.bezelView.transform = CGAffineTransform.identity
                UIView.animate(withDuration: duration, animations: {
                    self.bezelView.alpha = 0
                    if falling {
                        self.offset.y = 200
                        self.setNeedsLayout()
                        self.layoutIfNeeded()
                    }else {
                        self.bezelView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    }
                }, completion: { (finished) in
                    self.hide(animated: false)
                })
            }
        }
    }
    fileprivate var MBhud:_ProgressHUD?
    
    static fileprivate func createMBHUD(_ view:UIView) -> _ProgressHUD {
        let MBhud = _ProgressHUD(view: view)
        view.addSubview(MBhud)
        MBhud.removeFromSuperViewOnHide = true
        return MBhud
    }
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
    func hide() {
        self.MBhud?.hide()
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
    private static func show(_ text:String, icon:String, delay:TimeInterval, to view:UIView?) {
        Async.main {
            let view = view ?? jd.keyWindow
            
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
            let view = view ?? jd.keyWindow
            
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
