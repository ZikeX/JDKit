//
//  Alert.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class Alert: UIViewController {
    var baseView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension Alert {
    fileprivate func showAnimation(_ animationStyle: AlertAnimationStyle = .topToBottom, animationStartOffset: CGFloat = -400.0, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.2) {
        
        let rv = UIApplication.shared.keyWindow! as UIWindow
        var animationStartOrigin = self.baseView.frame.origin
        var animationCenter : CGPoint = rv.center
        
        switch animationStyle {
            
        case .noAnimation:
            self.view.alpha = 1.0
            return;
            
        case .topToBottom:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y + animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y + boundingAnimationOffset)
            
        case .bottomToTop:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y - animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y - boundingAnimationOffset)
            
        case .leftToRight:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x + animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x + boundingAnimationOffset, y: animationCenter.y)
            
        case .rightToLeft:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x - animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x - boundingAnimationOffset, y: animationCenter.y)
        }
        
        self.baseView.frame.origin = animationStartOrigin
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.alpha = 1.0
            self.baseView.center = animationCenter
        }, completion: { finished in
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.alpha = 1.0
                self.baseView.center = rv.center
            })
        })
    }
}
