//
//  UIStackView.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

extension UIStackView {
    convenience init(axis:UILayoutConstraintAxis = .horizontal, alignment:UIStackViewAlignment,distribution:UIStackViewDistribution = .fill,spacing:CGFloat = 0) {
        self.init()
        self.axis = axis
        self.alignment = alignment
        self.spacing = spacing
        self.distribution = distribution
    }
    func makeSpaces(_ spaces:[CGFloat]) {
        guard spaces.count > 0 else {
            return
        }
        var preItem:UIView?
        for (index,item) in self.arrangedSubviews.enumerated() {
            if let preItem = preItem {
                item.snp.makeConstraints({ (maker) in
                    let space:CGFloat
                    if index - 1 < spaces.count {
                        space = spaces[index - 1]
                    }else {
                        space = spaces.last!
                    }
                    if self.axis == .horizontal {
                        maker.leftSpace(preItem).offset(space)
                    }else {
                        maker.topSpace(preItem).offset(space)
                    }
                })
            }
            preItem = item
        }
    }
}
