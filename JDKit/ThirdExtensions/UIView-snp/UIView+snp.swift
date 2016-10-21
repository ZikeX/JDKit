//
//  UIView+snp.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import SnapKit

enum JDLayoutDirection {
    case horizontal
    case vertical
    case all
}
extension UIView {
    func snpSize(width:CGFloat? = nil,height:CGFloat? = nil) {
        self.snp.makeConstraints { (maker) in
            if let width = width {
                maker.width.equalTo(width)
            }
            if let height = height {
                maker.height.equalTo(height)
            }
        }
    }
    func sizeToView(_ otherView:UIView? = nil) {
        let _otherView = otherView ?? self.superview
        self.snp.makeConstraints { (maker) in
            maker.size.equalTo(_otherView!)
        }
    }
    func centerToView(otherView:UIView? = nil) {
        let _otherView = otherView ?? self.superview
        self.snp.makeConstraints { (maker) in
            maker.center.equalTo(_otherView!)
        }
    }
    func edgesToView(direction:JDLayoutDirection = .all,otherView:UIView? = nil,insets:UIEdgeInsets = UIEdgeInsets()) {
        let _otherView = otherView ?? self.superview!
        self.snp.makeConstraints { (maker) in
            switch direction {
            case .horizontal,.all:
                maker.left.equalTo(_otherView).offset(insets.left)
                maker.right.equalTo(_otherView).offset(-insets.right)
                if direction == .all {
                    fallthrough
                }
            case .vertical:
                maker.top.equalTo(_otherView).offset(insets.top)
                maker.bottom.equalTo(_otherView).offset(-insets.bottom)
            }
        }
    }
    func edgesToVC(_ viewController:UIViewController) {
        if self.superview == nil {
            viewController.view.addSubview(self)
        }
        self.snp.makeConstraints { (maker) in
            maker.left.centerX.equalTo(viewController.view)
            maker.top.equalTo(viewController.topLayoutGuide.snp.bottom)
            maker.bottom.equalTo(viewController.bottomLayoutGuide.snp.top)
        }
    }
    /// ZJaDe: 宽比高
    func aspectRatio(scale:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(self.snp.height).multipliedBy(scale)
        }
    }
    /// ZJaDe: 高比宽
    func heightWidthScale(scale:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.height.equalTo(self.snp.width).multipliedBy(scale)
        }
    }
}
