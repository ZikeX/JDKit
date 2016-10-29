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
    let disposeBag = DisposeBag()
    // MARK: - Button
    lazy var messageButton:Button = {
        let button = Button(image:R.image.ic_home_消息()?.templateImage)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe({ (event) in
            // TODO: 点击消息按钮时
        })
        return button
    }()
    lazy var shareButton:Button = {
        let button = Button(image: R.image.ic_share_navItem()?.templateImage)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe({ (event) in
            // TODO: 点击分享按钮时
        })
        return button
    }()
    lazy var menuButton:Button = {
        let button = Button(image: R.image.ic_menu()?.templateImage)
        button.tintColor = Color.black
        button.sizeToFit()
        _ = button.rx.tap.subscribe({ (event) in
            // TODO: 点击目录按钮时
        })
        return button
    }()
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
        self.automaticallyAdjustsScrollViewInsets = false
        configInitAboutNavBar()
        configInitAboutViewState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.viewBackground
    }
}
