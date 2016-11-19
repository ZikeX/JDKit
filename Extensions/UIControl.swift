//
//  UIControl.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

extension UIControl {
    func addHighlightedShadowAnimate(_ heightedColor:UIColor? = nil) {
        logInfo("RxSwiftVersionNumber->\(RxSwiftVersionNumber)")
        _ = self.rx.observe(Bool.self, "highlighted", retainSelf: false).debug().takeUntil(rx.deallocated).distinctUntilChanged{$0==$1&&$1==nil}.subscribe { (event) in
            if let element = event.element,let isHighlighted = element {
                self.shadow(isHighlighted: isHighlighted, animated: true)
            }
        }
        
        _ = Observable.just(self)
            .flatMap {
                $0.rx.observe(Bool.self, "highlighted")
        }.takeUntil(rx.deallocated).subscribe { (bool) in
            
        }
        _ = rx.deallocated.subscribe { (_) in
            logDebug("UIControl - deallocated")
        }
        
        logInfo("RxSwiftVersionNumber->\(RxSwiftVersionNumber)")
    }
}
