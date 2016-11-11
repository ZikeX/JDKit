//
//  UpdateLayout.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/11.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import SnapKit

private var updateLayoutArrKey: UInt8 = 0
extension UIView {
    var updateLayout:UpdateLayout {
        return UpdateLayout(view: self)
    }
}
class UpdateLayout {
    let view:UIView
    lazy var constraintArr:[Constraint] = {
        var constraintArr: [Constraint]
        if let existing = objc_getAssociatedObject(self.view, &updateLayoutArrKey) as? [Constraint] {
            constraintArr = existing
        } else {
            constraintArr = [Constraint]()
            objc_setAssociatedObject(self.view, &updateLayoutArrKey, constraintArr, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return constraintArr
    }()
    // MARK: -
    deinit {
        objc_setAssociatedObject(self.view, &updateLayoutArrKey, self.constraintArr, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    init(view:UIView) {
        self.view = view
    }
    // MARK: -
    func activate() {
        self.constraintArr.forEach { (constraint) in
            constraint.activate()
        }
    }
    func deactivate() {
        self.constraintArr.forEach { (constraint) in
            constraint.deactivate()
        }
        constraintArr.removeAll()
    }
}
