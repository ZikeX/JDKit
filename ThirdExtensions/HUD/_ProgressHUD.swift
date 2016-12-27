//
//  _ProgressHUD.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import MBProgressHUD

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
    func hide(delay:TimeInterval = 0, duration:TimeInterval = 1.5,falling:Bool = false, closure:(()->())? = nil) {
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
                closure?()
            })
        }
    }
}
