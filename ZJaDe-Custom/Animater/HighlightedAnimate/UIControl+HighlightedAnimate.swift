//
//  UIControl+HighlightedAnimate.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
private var controlHighlightedBagKey:UInt8 = 0
extension UIControl {
    private var highlightedDisposeBag:DisposeBag! {
        get {
            return associatedObject(&controlHighlightedBagKey)
        } set {
            setAssociatedObject(&controlHighlightedBagKey, newValue)
        }
    }
    func configHighlightAnimates() {
        if highlightedDisposeBag == nil {
            highlightedDisposeBag = DisposeBag()
            self.rx.observe(Bool.self, "highlighted",retainSelf: false).distinctUntilChanged{$0==$1}.subscribe(onNext: {[unowned self] (highlighted) in
                if let highlighted = highlighted {
                    if self.hasHighlightedShadowAnimate {
                        logDebug("\(self)->isHighlighted->\(highlighted)")
                        self.shadow(isHighlighted: highlighted, animated: true)
                    }
                    if self.hasHighlightedColorAnimate {
                        self.highlightedViewAnimate(highlighted)
                    }
                }
            }).addDisposableTo(highlightedDisposeBag)
        }
    }
}
private var controlShadowAnimateKey:UInt8 = 0
extension UIControl {
    fileprivate var hasHighlightedShadowAnimate:Bool {
        get {
            return associatedObject(&controlShadowAnimateKey, createIfNeed: {false})
        } set {
            if hasHighlightedShadowAnimate != newValue {
                setAssociatedObject(&controlShadowAnimateKey, newValue)
                configHighlightAnimates()
            }
        }
    }
    func addHighlightedShadowAnimate() {
        hasHighlightedShadowAnimate = true
    }
    func removeHighlightedShadowAnimate() {
        hasHighlightedShadowAnimate = false
    }
}
private var controlHighlightedColorAnimateKey:UInt8 = 0
extension UIControl {
    fileprivate var hasHighlightedColorAnimate:Bool {
        get {
            return associatedObject(&controlHighlightedColorAnimateKey, createIfNeed: {false})
        } set {
            if hasHighlightedColorAnimate != newValue {
                setAssociatedObject(&controlHighlightedColorAnimateKey, newValue)
                configHighlightAnimates()
            }
        }
    }
    func addHighlightedColorAnimate(_ highlightedColor:UIColor = Color.selectedCell) {
        self.highlightedView.backgroundColor = highlightedColor
        hasHighlightedColorAnimate = true
    }
    func removeHighlightedColorAnimate() {
        hasHighlightedColorAnimate = false
    }
}
