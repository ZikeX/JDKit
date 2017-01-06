//
//  BaseAlert.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/6.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit

class BaseAlert: WindowBgView {
    let baseView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView.cornerRadius = 5
        self.baseView.clipsToBounds = true
        self.baseView.backgroundColor = Color.white
        self.configShowAnimate(animated: false) {[unowned self] in
            self.view.addSubview(self.baseView)
            self.showAnimation()
        }
        self.configBaseLayout()
    }
    func configBaseLayout() {
        fatalError("子类实现")
    }
}
extension BaseAlert {
    fileprivate func showAnimation(_ animationStyle: AlertAnimationStyle = .topToBottom, animationStartOffset: CGFloat = -400.0, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.75) {
        
        let rv = jd.keyWindow
        var animationStartOrigin = self.baseView.origin
        var animationCenter : CGPoint = rv.center
        
        switch animationStyle {
            
        case .noAnimation:
            return;
            
        case .topToBottom:
            animationStartOrigin.y += animationStartOffset
            animationCenter.y += boundingAnimationOffset
            
        case .bottomToTop:
            animationStartOrigin.y -= animationStartOffset
            animationCenter.y -= boundingAnimationOffset
            
        case .leftToRight:
            animationStartOrigin.x += animationStartOffset
            animationCenter.x += boundingAnimationOffset
            
        case .rightToLeft:
            animationStartOrigin.x -= animationStartOffset
            animationCenter.x -= boundingAnimationOffset
        }
        
        self.baseView.origin = animationStartOrigin
        self.baseView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: animationDuration, animations: {
            self.baseView.center = animationCenter
            self.baseView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { finished in
            UIView.spring(duration: animationDuration, animations: {
                self.baseView.center = rv.center
                self.baseView.transform = CGAffineTransform.identity
            })
        })
    }
}
