//
//  UIControl.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

extension UIControl {
    func addHighlightedShadowAnimate(_ heightedColor:UIColor? = nil) {
        self.rx.observe(Bool.self, "highlighted",retainSelf: false).subscribe(onNext: {[unowned self] (highlighted) in
            if let highlighted = highlighted {
                self.shadow(isHighlighted: highlighted, animated: true)
            }
        }).addDisposableTo(disposeBag)
    }
}
