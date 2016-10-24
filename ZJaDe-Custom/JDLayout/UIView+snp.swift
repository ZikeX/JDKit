//
//  UIView+snp.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
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
    /// ZJaDe: 宽比高
    func widthHeightSacle(scale:CGFloat) {
        self.jdLayout.widthHeightSacle(scale).activate()
    }
    /// ZJaDe: 高比宽
    func heightWidthScale(scale:CGFloat) {
        self.jdLayout.heightWidthSacle(scale).activate()
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
