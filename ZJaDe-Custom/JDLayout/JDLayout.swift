//
//  JDLayout.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import SnapKit

private var layoutArrKey: UInt8 = 0
extension UIView {
    var jdLayout:JDLayout {
        return JDLayout(view: self)
    }
}
class JDLayout {
    let view:UIView
    lazy var constraintArr:[Constraint] = {
        var constraintArr: [Constraint]
        if let existing = objc_getAssociatedObject(self.view, &layoutArrKey) as? [Constraint] {
            constraintArr = existing
        } else {
            constraintArr = [Constraint]()
                objc_setAssociatedObject(self.view, &layoutArrKey, constraintArr, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return constraintArr
    }()
    // MARK: -
    deinit {
        objc_setAssociatedObject(self.view, &layoutArrKey, self.constraintArr, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    init(view:UIView) {
        self.view = view
        self.view.translatesAutoresizingMaskIntoConstraints = false
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
extension JDLayout {
    func widthValue(width:CGFloat) -> JDLayout {
        return self.sizeValue(width: width)
    }
    func heightValue(height:CGFloat) -> JDLayout {
        return self.sizeValue(height: height)
    }
    func sizeValue(width:CGFloat? = nil,height:CGFloat? = nil) -> JDLayout {
        let constraints = self.view.snp.prepareConstraints { (maker) in
            if let width = width {
                maker.width.equalTo(width)
            }
            if let height = height {
                maker.height.equalTo(height)
            }
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func width_height(scale:CGFloat,view:UIView? = nil,offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.width.equalTo(view.snp.height).multipliedBy(scale).offset(offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func height_width(scale:CGFloat,view:UIView? = nil,offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.height.equalTo(view.snp.width).multipliedBy(scale).offset(offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func widthSacle(_ scale:CGFloat,view:UIView,offset:CGFloat = 0) -> JDLayout {
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.width.equalTo(view).multipliedBy(scale).offset(offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func heightSacle(_ scale:CGFloat,view:UIView,offset:CGFloat = 0) -> JDLayout {
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.height.equalTo(view).multipliedBy(scale).offset(offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
}
enum JDLayoutDirection {
    case horizontal
    case vertical
    case all
}
extension JDLayout {
    func edgesAlignToVC(direction:JDLayoutDirection = .all, _ viewController:UIViewController, inset:UIEdgeInsets = UIEdgeInsets()) -> JDLayout {
        if self.view.superview == nil {
            viewController.view.addSubview(self.view)
        }
        let constraints = self.view.snp.prepareConstraints { (maker) in
            switch direction {
            case .horizontal,.all:
                maker.leftAlign(viewController.view).offset(inset.left)
                maker.rightAlign(viewController.view).offset(-inset.right)
                if direction == .all {
                    fallthrough
                }
            case .vertical:
                maker.top.equalTo(viewController.topLayoutGuide.snp.bottom).offset(inset.top)
                maker.bottom.equalTo(viewController.bottomLayoutGuide.snp.top).offset(-inset.bottom)
            }
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func edgesAlign(_ direction:JDLayoutDirection = .all, view:UIView? = nil, inset:UIEdgeInsets = UIEdgeInsets()) -> JDLayout {
        let view = view ?? self.view.superview!
        let constraints = self.view.snp.prepareConstraints { (maker) in
            switch direction {
            case .horizontal,.all:
                maker.leftAlign(view).offset(inset.left)
                maker.rightAlign(view).offset(-inset.right)
                if direction == .all {
                    fallthrough
                }
            case .vertical:
                maker.topAlign(view).offset(inset.top)
                maker.bottomAlign(view).offset(-inset.bottom)
            }
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func sizeAlign(_ view:UIView? = nil) -> JDLayout {
        let view = view ?? self.view.superview!
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.sizeAlign(view)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func centerAlign(_ view:UIView? = nil) -> JDLayout {
        let view = view ?? self.view.superview!
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.centerAlign(view)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
}
extension JDLayout {
    func centerXAlign(_ view:UIView? = nil, offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.centerXAlign(view, offset: offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func centerYAlign(_ view:UIView? = nil, offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.centerYAlign(view, offset: offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
}
extension JDLayout {
    func topAlign(_ view:UIView? = nil, offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.topAlign(view, offset: offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func bottomAlign(_ view:UIView? = nil, offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.bottomAlign(view, offset: offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func leftAlign(_ view:UIView? = nil, offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.leftAlign(view, offset: offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func rightAlign(_ view:UIView? = nil, offset:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.rightAlign(view, offset: offset)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
}
extension JDLayout {
    func topSpaceToVC(_ viewController:UIViewController, space:CGFloat = 0) -> JDLayout {
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.topSpaceToVC(viewController, space: space)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func bottomSpaceToVC(viewController:UIViewController, space:CGFloat = 0) -> JDLayout {
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.bottomSpaceToVC(viewController, space: space)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
}
extension JDLayout {
    func topSpace(_ view:UIView? = nil, space:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.topSpace(view, space: space)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func bottomSpace(_ view:UIView? = nil, space:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.bottomSpace(view, space: space)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func leftSpace(_ view:UIView? = nil, space:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.leftSpace(view, space: space)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
    func rightSpace(_ view:UIView? = nil, space:CGFloat = 0) -> JDLayout {
        let view = view ?? self.view.superview
        let constraints = self.view.snp.prepareConstraints { (maker) in
            maker.rightSpace(view, space: space)
        }
        self.constraintArr.append(contentsOf: constraints)
        return self
    }
}
