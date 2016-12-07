//
//  UIView+MainAnimation.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/7.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

let UIViewAnimationDuration: TimeInterval = 0.25
let UIViewAnimationSpringDamping: CGFloat = 0.8
let UIViewAnimationSpringVelocity: CGFloat = 10

enum ShakeDirection {
    case horizontal
    case vertical
}

extension UIView {
    ///加这个方法只是为了不用completion时，不报错误
    static func spring(duration:TimeInterval, animations: @escaping (() -> Void)) {
        self.spring(duration: duration, animations: animations, completion: nil)
    }
    static func spring(duration:TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    func shake(_ times: Int = 10,shakeDirection:ShakeDirection = .horizontal) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        switch shakeDirection {
        case .horizontal:
            anim.values = [
                NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
                NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))]
        case .vertical:
            anim.values = [
                NSValue(caTransform3D: CATransform3DMakeTranslation( 0, -5, 0 )),
                NSValue(caTransform3D: CATransform3DMakeTranslation( 0,  5, 0 ))]
        }
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 0.03
        
        self.layer.add(anim, forKey: nil)
    }
    
}
