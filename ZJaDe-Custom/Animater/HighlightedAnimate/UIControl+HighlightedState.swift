//
//  UIControl+Animation.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/16.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

private var highlightedViewKey:UInt8 = 0
private var highlightedBgViewKey:UInt8 = 0
extension UIControl {
    private var highlightedBgView:UIView {
        get {
            return associatedObject(&highlightedBgViewKey, createIfNeed: {UIView()})
        }
        set {
            setAssociatedObject(&highlightedBgViewKey, newValue)
        }
    }
    var highlightedView:UIView {
        get {
            return associatedObject(&highlightedViewKey, createIfNeed: {UIView()})
        }
        set {
            setAssociatedObject(&highlightedViewKey, newValue)
        }
    }
    func highlightedViewAnimate(_ isHighlighted:Bool) {
        if isHighlighted {
            self.insertSubview(self.highlightedBgView, at: 0)
            self.highlightedBgView.frame = self.bounds
            self.highlightedBgView.clipsToBounds = true
            self.highlightedBgView.insertSubview(self.highlightedView, at:0)
            
            let length = self.height + self.width
            self.highlightedView.size = CGSize(width: length, height: length)
            self.highlightedView.center = CGPoint(x: self.width / 2, y: self.height / 2)
            self.highlightedView.cornerRadius = length / 2
            
            self.highlightedView.alpha = 0
            
            self.highlightedView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.spring(duration: 0.75, animations: {
                self.highlightedView.alpha = 1
                self.highlightedView.transform = CGAffineTransform.identity
            })
        }else {
            UIView.spring(duration: 0.75, animations: {
                self.highlightedView.alpha = 0
                self.highlightedView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { (finished) in
                self.highlightedView.transform = CGAffineTransform.identity
                self.highlightedView.removeFromSuperview()
                self.highlightedBgView.removeFromSuperview()
            })
        }
    }
}
