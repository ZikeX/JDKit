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
    
    lazy var titleLabel:UILabel = {
        let label = UILabel(color: Color.navBarTintColor, font: Font.p24)
        return label
    }()
    var navItemTitle:String {
        get {
            return self.titleLabel.text ?? ""
        }
        set {
            self.titleLabel.text = newValue
            self.titleLabel.sizeToFit()
            let navItem:UINavigationItem
            if self.parent is UITabBarController {
                navItem = self.tabBarController!.navigationItem
            }else {
                navItem = self.navigationItem
            }
            if navItem.titleView != self.titleLabel {
                navItem.titleView = self.titleLabel
            }
        }
    }
    // MARK: - Button
    lazy var messageButton:Button = {
        let button = Button(image:R.image.ic_home_消息(),isTemplate:true)
        button.tintColor = Color.navBarTintColor
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            // TODO: 点击消息按钮时
        })
        return button
    }()
    lazy var shareButton:Button = {
        let button = Button(image: R.image.ic_share_navItem(),isTemplate:true)
        button.tintColor = Color.navBarTintColor
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            // TODO: 点击分享按钮时
        })
        return button
    }()
    lazy var menuButton:Button = {
        let button = Button(image: R.image.ic_menu(),isTemplate:true)
        button.tintColor = Color.navBarTintColor
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            // TODO: 点击目录按钮时
        })
        return button
    }()
    lazy var doneButton:Button = {
        let button = Button(title: "完成")
        button.tintColor = Color.navBarTintColor
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            
        })
        return button
    }()
    lazy var cacelButton:Button = {
        let button = Button(image: R.image.ic_cancel(),isTemplate:true)
        button.tintColor = Color.navBarTintColor
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
        button.tintColor = Color.navBarTintColor
        button.sizeToFit()
        button.rx.touchUpInside({[unowned self] (button) in
            self.popVC()
        })
        return button
    }()
    lazy var backItem:UIBarButtonItem = {
        let item = UIBarButtonItem.image(R.image.ic_back()!, {[unowned self] (item) in
            self.popVC()
        })
        return item
    }()
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
        self.BConfigInit()
    }
}
extension BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.BViewWillAppear()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.BViewDidAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.BViewWillDisappear()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.BViewDidDisappear()
    }
}
