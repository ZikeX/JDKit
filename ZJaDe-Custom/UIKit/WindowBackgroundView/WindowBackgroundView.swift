//
//  WindowBackgroundView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/1.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class WindowBackgroundView: UIView {
    
    init() {
        super.init(frame:CGRect(x: 0, y: 0, width: jd.screenWidth, height: jd.screenHeight))
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -
    lazy var backView:UIView = {
        let backView = UIView()
        backView.backgroundColor = Color.darkBlack.withAlphaComponent(0.4)
        backView.frame = self.bounds
        
        _ = backView.getTap().rx.event.subscribe(onNext: {[unowned self] (event) in
            self.hide()
        })
        return backView
    }()
    
    func configInit() {
        let window = jd.rootWindow
        window.addSubview(self)
        self.addSubview(backView)
        self.alpha = 0
    }
    
    var showClosure:(()->())?
    var hideClosure:(()->())?
}
extension WindowBackgroundView {
    func show() {
        UIView.spring(duration: 0.5) {
            self.alpha = 1
            self.showClosure?()
        }
    }
    func hide() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
            self.hideClosure?()
        }) { (finish) in
            self.removeFromSuperview()
        }
    }
}
