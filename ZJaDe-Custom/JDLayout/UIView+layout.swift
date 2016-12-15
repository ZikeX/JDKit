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
    func edgesToVC(_ viewController:UIViewController,edgesToFill:Bool = false) {
        if self.parent == nil {
            viewController.addChildViewController(self)
        }
        if edgesToFill {
            if self.view.superview == nil {
                viewController.view.addSubview(self.view)
            }
            self.view.edgesToView()
        }else {
            self.view.edgesToVC(viewController)
        }
    }
}
extension UIView {
    func edgesToVC(_ viewController:UIViewController) {
        if self.superview == nil {
            viewController.view.addSubview(self)
        }
        self.snp.makeConstraints { (maker) in
            maker.left.equalTo(viewController.view)
            maker.right.equalTo(viewController.view)
            maker.topSpaceToVC(viewController)
            maker.bottomSpaceToVC(viewController)
        }
    }
    func edgesToView() {
        self.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
        }
    }
    /// ZJaDe: 设置宽高
    func widthValue(width:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(width)
        }
    }
    func heightValue(height:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.height.equalTo(height)
        }
    }
    func sizeValue(width:CGFloat,height:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.size.equalTo(CGSize(width: width, height: height))
        }
    }
    /// ZJaDe: 宽比高
    func width_height(scale:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.width_height(scale: scale)
        }
    }
    /// ZJaDe: 高比宽
    func height_width(scale:CGFloat) {
        self.snp.makeConstraints { (maker) in
            maker.height_width(scale: scale)
        }
    }
}
extension UIView {
    func contentPriority(_ priority:UILayoutPriority) {
        self.contentHuggingPriority(priority)
        self.contentCompressionResistancePriority(priority)
    }
    func contentVerticalPriority(_ priority:UILayoutPriority) {
        self.contentHuggingVerticalPriority = priority
        self.contentCompressionResistanceVerticalPriority = priority
    }
    func contentHorizontalPriority(_ priority:UILayoutPriority) {
        self.contentCompressionResistanceHorizontalPriority = priority
        self.contentHuggingHorizontalPriority = priority
    }
    func contentHuggingPriority(_ priority:UILayoutPriority) {
        self.contentHuggingVerticalPriority = priority
        self.contentHuggingHorizontalPriority = priority
    }
    func contentCompressionResistancePriority(_ priority:UILayoutPriority) {
        self.contentCompressionResistanceHorizontalPriority = priority
        self.contentCompressionResistanceVerticalPriority = priority
    }
    // MARK: -
    var contentHuggingHorizontalPriority: UILayoutPriority {
        get {
            return self.contentHuggingPriority(for: .horizontal)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .horizontal)
        }
    }
    
    var contentHuggingVerticalPriority: UILayoutPriority {
        get {
            return self.contentHuggingPriority(for: .vertical)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .vertical)
        }
    }
    
    var contentCompressionResistanceHorizontalPriority: UILayoutPriority {
        get {
            return self.contentCompressionResistancePriority(for: .horizontal)
        }
        set {
            self.setContentCompressionResistancePriority(newValue, for: .horizontal)
        }
    }
    
    var contentCompressionResistanceVerticalPriority: UILayoutPriority {
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
        return associatedObject(&centerLayoutViewKey, createIfNeed: { () -> UIView in
            let centerLayoutView = UIView()
            self.addSubview(centerLayoutView)
            centerLayoutView.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.left.greaterThanOrEqualTo(self)
                maker.top.greaterThanOrEqualTo(self)
            })
            return centerLayoutView
        })
    }
    var centerStackView:UIStackView {
        return associatedObject(&centerStackViewKey, createIfNeed: { () -> UIStackView in
            let centerStackView = UIStackView(alignment: .center, distribution: .equalCentering)
            self.addSubview(centerStackView)
            centerStackView.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.left.greaterThanOrEqualTo(self)
                maker.top.greaterThanOrEqualTo(self)
            })
            return centerStackView
        })
    }
}
extension UIView {
    typealias LayoutViewClosureType = (UIView,ConstraintMaker) -> ()
    @discardableResult
    func remakeLayoutView(_ closure:@escaping LayoutViewClosureType) -> UIView {
        self.snp.remakeConstraints { (maker) in
            closure(self,maker)
        }
        return self
    }
    @discardableResult
    func makeLayoutView(_ closure:@escaping LayoutViewClosureType) -> UIView {
        self.snp.makeConstraints { (maker) in
            closure(self,maker)
        }
        return self
    }
    func updateLayoutView(_ closure:@escaping LayoutViewClosureType) -> UIView {
        self.snp.updateConstraints { (maker) in
            closure(self,maker)
        }
        return self
    }
}
