//
//  ConstraintMaker.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//
import UIKit
import SnapKit
extension ConstraintMaker {
    /// ZJaDe: 宽比高
    func width_height(scale:CGFloat) {
        self.width.equalTo(self.view.snp.height).multipliedBy(scale)
    }
    /// ZJaDe: 高比宽
    func height_width(scale:CGFloat) {
        self.height.equalTo(self.view.snp.width).multipliedBy(scale)
    }
}
extension ConstraintMaker {
    @discardableResult
    func topSpaceToVC(_ viewController:UIViewController)->ConstraintMakerEditable {
        return self.top.equalTo(viewController.topLayoutGuide.snp.bottom)
    }
    @discardableResult
    func bottomSpaceToVC(_ viewController:UIViewController)->ConstraintMakerEditable {
        return self.bottom.equalTo(viewController.bottomLayoutGuide.snp.top)
    }
}
extension ConstraintMaker {
    @discardableResult
    func topSpace(_ view:UIView)->ConstraintMakerEditable {
        return self.top.equalTo(view.snp.bottom)
    }
    @discardableResult
    func bottomSpace(_ view:UIView)->ConstraintMakerEditable {
        return self.bottom.equalTo(view.snp.top)
    }
    @discardableResult
    func leftSpace(_ view:UIView)->ConstraintMakerEditable {
        return self.left.equalTo(view.snp.right)
    }
    @discardableResult
    func rightSpace(_ view:UIView)->ConstraintMakerEditable {
        return self.right.equalTo(view.snp.left)
    }
}
