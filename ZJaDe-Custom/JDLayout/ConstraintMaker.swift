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
    func edgesAlign(_ view:UIView?=nil,inset:UIEdgeInsets)->ConstraintMakerEditable {
        if let view = view {
            return self.edges.equalTo(view).inset(inset)
        }else {
            return self.edges.equalToSuperview().inset(inset)
        }
    }
    @discardableResult
    func centerAlign(_ view:UIView?=nil)->ConstraintMakerEditable {
        if let view = view{
            return self.center.equalTo(view)
        }else {
            return self.center.equalToSuperview()
        }
    }
    @discardableResult
    func sizeAlign(_ view:UIView?=nil)->ConstraintMakerEditable {
        if let view = view {
            return self.size.equalTo(view)
        }else {
            return self.size.equalToSuperview()
        }
    }
}
extension ConstraintMaker {
    @discardableResult
    func centerXAlign(_ view:UIView?=nil, offset:ConstraintOffsetTarget)->ConstraintMakerEditable {
        if let view = view {
            return self.centerX.equalTo(view).offset(offset)
        }else {
            return self.centerX.equalToSuperview().offset(offset)
        }
    }
    @discardableResult
    func centerYAlign(_ view:UIView?=nil, offset:ConstraintOffsetTarget)->ConstraintMakerEditable {
        if let view = view {
            return self.centerY.equalTo(view).offset(offset)
        }else {
            return self.centerY.equalToSuperview().offset(offset)
        }
    }
    @discardableResult
    func topAlign(_ view:UIView?=nil, offset:ConstraintOffsetTarget)->ConstraintMakerEditable {
        if let view = view {
            return self.top.equalTo(view).offset(offset)
        }else {
            return self.top.equalToSuperview().offset(offset)
        }
    }
    @discardableResult
    func bottomAlign(_ view:UIView?=nil, offset:ConstraintOffsetTarget)->ConstraintMakerEditable {
        if let view = view {
            return self.bottom.equalTo(view).offset(offset)
        }else {
            return self.bottom.equalToSuperview().offset(offset)
        }
    }
    @discardableResult
    func leftAlign(_ view:UIView?=nil, offset:ConstraintOffsetTarget)->ConstraintMakerEditable {
        if let view = view {
            return self.left.equalTo(view).offset(offset)
        }else {
            return self.left.equalToSuperview().offset(offset)
        }
    }
    @discardableResult
    func rightAlign(_ view:UIView?=nil, offset:ConstraintOffsetTarget)->ConstraintMakerEditable {
        if let view = view {
            return self.right.equalTo(view).offset(offset)
        }else {
            return self.right.equalToSuperview().offset(offset)
        }
    }
}
extension ConstraintMaker {
    @discardableResult
    func topSpaceToVC(_ viewController:UIViewController, space:ConstraintOffsetTarget = 0)->ConstraintMakerEditable {
        return self.top.equalTo(viewController.topLayoutGuide.snp.bottom).offset(space)
    }
    @discardableResult
    func bottomSpaceToVC(_ viewController:UIViewController, space:ConstraintOffsetTarget = 0)->ConstraintMakerEditable {
        return self.bottom.equalTo(viewController.bottomLayoutGuide.snp.top).offset(space)
    }
}
extension ConstraintMaker {
    @discardableResult
    func topSpace(_ view:UIView, space:ConstraintOffsetTarget)->ConstraintMakerEditable {
        return self.top.equalTo(view.snp.bottom).offset(space)
    }
    @discardableResult
    func bottomSpace(_ view:UIView, space:ConstraintOffsetTarget)->ConstraintMakerEditable {
        return self.bottom.equalTo(view.snp.top).offset(space)
    }
    @discardableResult
    func leftSpace(_ view:UIView, space:ConstraintOffsetTarget)->ConstraintMakerEditable {
        return self.left.equalTo(view.snp.right).offset(space)
    }
    @discardableResult
    func rightSpace(_ view:UIView, space:ConstraintOffsetTarget)->ConstraintMakerEditable {
        return self.right.equalTo(view.snp.left).offset(space)
    }
}
