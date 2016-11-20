//
//  JDViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class BaseViewController: UIViewController {
    // MARK: - Button
    lazy var messageButton:Button = {
        let button = Button(image:R.image.ic_home_消息(),isTemplate:true)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe(onNext: {[unowned self] (event) in
            // TODO: 点击消息按钮时
        })
        return button
    }()
    lazy var shareButton:Button = {
        let button = Button(image: R.image.ic_share_navItem(),isTemplate:true)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe(onNext: {[unowned self] (event) in
            // TODO: 点击分享按钮时
        })
        return button
    }()
    lazy var menuButton:Button = {
        let button = Button(image: R.image.ic_menu(),isTemplate:true)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe(onNext: {[unowned self] (event) in
            // TODO: 点击目录按钮时
        })
        return button
    }()
    lazy var cacelButton:Button = {
        let button = Button(image: R.image.ic_cancel(),isTemplate:true)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe(onNext: {[unowned self] (event) in
            self.cacelVC()
        })
        return button
    }()
    func cacelVC() {
        self.navigationController?.dismissVC()
    }
    // MARK: - 
    lazy var transitionVC:TransitionViewController = TransitionViewController()
    // MARK: -
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.baseVCConfigInit()
    }
}
extension BaseViewController {
    func addTransitionVC(edgesToFill:Bool = false) {
        self.transitionVC.edgesToVC(self, edgesToFill: edgesToFill)
        self.configTransitionVC(edgesToFill: edgesToFill)
    }
    func configTransitionVC(edgesToFill: Bool) {
            
    }
}

