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
}
