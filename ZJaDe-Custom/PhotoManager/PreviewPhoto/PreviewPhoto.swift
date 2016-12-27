//
//  PreviewPhoto.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class PreviewPhoto {
    static let shared = PreviewPhoto()
    private init() {
    }
    // MARK: -
    private let mainView:PageScrollView = {
        let scrollView = PageScrollView()
        scrollView.sizeValue(width: jd.screenSize.width - 40, height: jd.screenSize.height - 100)
        return scrollView
    }()
    private var hud:HUD?
    
    func show(_ imgArray:[ImageDataProtocol]) {
        mainView.imgArray = imgArray
        hud = HUD().custom { (backgroundView) -> UIView in
            return self.mainView
        }
        self.hud!.showNoAnimate()
        let custom = self.hud!.MBhud!
        
        custom.backgroundView.rx.whenTouch {[unowned self] (backgroundView) in
            self.hide()
        }.addDisposableTo(custom.disposeBag)
        
        custom.alpha = 0
        custom.bezelView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.spring(duration: 0.75) {
            custom.alpha = 1
            custom.bezelView.transform = CGAffineTransform.identity
        }
    }
    func hide() {
        UIView.animate(withDuration: 0.75, animations: { 
            self.hud!.MBhud!.alpha = 0
        }, completion: { (finished) in
            self.hud!.hideNoAnimate()
        })
    }
}
