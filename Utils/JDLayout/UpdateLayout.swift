//
//  UpdateLayout.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/11.
//  Copyright © 2016 Z_JaDe. All rights reserved.
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
    var constraintArr:[Constraint] {
        get {
            return self.view.associatedObject(&updateLayoutArrKey, createIfNeed:{[Constraint]()})
        }
        set {
            self.view.setAssociatedObject(&updateLayoutArrKey, newValue)
        }
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
