//
//  UIView+layout.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    func edgesToVC(_ viewController:UIViewController) {
        if self.parent == nil {
            viewController.addChildViewController(self)
        }
        self.view.jdLayout.edgesAlignToVC(viewController).activate()
    }
}
extension UIView {
    func edgesToVC(_ viewController:UIViewController) {
        self.jdLayout.edgesAlignToVC(viewController).activate()
    }
    func edgesToView() {
        self.jdLayout.edgesAlign().activate()
    }
    /// ZJaDe: 设置宽高
    func widthValue(width:CGFloat) {
        self.jdLayout.sizeValue(width: width).activate()
    }
    func heightValue(height:CGFloat) {
        self.jdLayout.sizeValue(height: height).activate()
    }
    func sizeValue(width:CGFloat,height:CGFloat) {
        self.jdLayout.sizeValue(width: width, height: height).activate()
    }
    /// ZJaDe: 宽比高
    func width_height(scale:CGFloat) {
        self.jdLayout.width_height(scale: scale).activate()
    }
    /// ZJaDe: 高比宽
    func height_width(scale:CGFloat) {
        self.jdLayout.height_width(scale: scale).activate()
    }
}
extension UIView {
    var contentHuggingHorizontalPriority: Float {
        get {
            return self.contentHuggingPriority(for: .horizontal)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .horizontal)
        }
    }
    
    var contentHuggingVerticalPriority: Float {
        get {
            return self.contentHuggingPriority(for: .vertical)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .vertical)
        }
    }
    
    var contentCompressionResistanceHorizontalPriority: Float {
        get {
            return self.contentCompressionResistancePriority(for: .horizontal)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .horizontal)
        }
    }
    
    var contentCompressionResistanceVerticalPriority: Float {
        get {
            return self.contentCompressionResistancePriority(for: .vertical)
        }
        set {
            self.setContentCompressionResistancePriority(newValue, for: .vertical)
        }
    }
}
private var centerLayoutViewKey:UInt8 = 0
private var centerStackViewKey:UInt8 = 0
extension UIView {
    var centerLayoutView:UIView {
        var centerLayoutView: UIView
        if let existing = objc_getAssociatedObject(self, &centerLayoutViewKey) as? UIView {
            centerLayoutView = existing
        }else {
            centerLayoutView = UIView()
            self.addSubview(centerLayoutView)
            centerLayoutView.jdLayout.centerAlign().activate()
            objc_setAssociatedObject(self, &centerLayoutViewKey, centerLayoutView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return centerLayoutView
    }
    var centerStackView:UIStackView {
        var centerStackView: UIStackView
        if let existing = objc_getAssociatedObject(self, &centerStackViewKey) as? UIStackView {
            centerStackView = existing
        }else {
            centerStackView = UIStackView(alignment: .center, distribution: .equalCentering)
            self.addSubview(centerLayoutView)
            centerLayoutView.jdLayout.centerAlign().activate()
            objc_setAssociatedObject(self, &centerStackViewKey, centerLayoutView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return centerStackView
    }
}
