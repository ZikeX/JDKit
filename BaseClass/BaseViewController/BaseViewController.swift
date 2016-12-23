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
import FBRetainCycleDetector

class BaseViewController: UIViewController {
    var hasSegmentedControl:Bool = false
    
    // MARK: - Button
    lazy var messageButton:Button = {
        let button = Button(image:R.image.ic_home_消息(),isTemplate:true)
        button.sizeToFit()
        return button
    }()
    lazy var shareButton:Button = {
        let button = Button(image: R.image.ic_share_navItem(),isTemplate:true)
        button.sizeToFit()
        return button
    }()
    lazy var menuButton:Button = {
        let button = Button(image: R.image.ic_menu(),isTemplate:true)
        button.sizeToFit()
        return button
    }()
    lazy var doneButton:Button = {
        let button = Button(title: "完成")
        button.sizeToFit()
        return button
    }()
    lazy var cacelButton:Button = {
        let button = Button(image: R.image.ic_cancel(),isTemplate:true)
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            self.cacelVC()
        })
        return button
    }()
    func cacelVC() {
        self.navigationController?.dismissVC()
    }
    lazy var backButton:Button = {
        let button = Button(image: R.image.ic_back(),isTemplate:true)
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            self.popVC()
        })
        return button
    }()
    // MARK: - transitionVC
    lazy var transitionVC:TransitionViewController = TransitionViewController()
    // MARK: - init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.jdConfigInit()
    }
    // MARK: - BaseVCProtocol
    var isFirstIn: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.jdViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.jdViewWillAppear()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.jdViewDidAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.jdViewWillDisappear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.jdViewDidDisappear()
    }
}
