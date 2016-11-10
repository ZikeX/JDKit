//
//  UIControl.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension UIControl {
    func addHeightedShadowAnimate() {
        self.removeTarget(self, action: #selector(whenTouchDown), for: .touchDown)
        self.removeTarget(self, action: #selector(whenTouchUp), for: .touchUpInside)
        self.removeTarget(self, action: #selector(whenTouchUp), for: .touchUpOutside)
        self.addTarget(self, action: #selector(whenTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(whenTouchUp), for: .touchUpInside)
        self.addTarget(self, action: #selector(whenTouchUp), for: .touchUpOutside)
    }
    @objc private func whenTouchDown() {
        self.shadow(isHighlighted: true, animated: true)
    }
    @objc private func whenTouchUp() {
        self.shadow(isHighlighted: false, animated: true)
    }
}
