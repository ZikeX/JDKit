//
//  BaseTabBarController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import JDAnimatedTabBarController
import RxSwift
class BaseTabBarController: JDAnimatedTabBarController {
    
    override func configInit() {
        super.configInit()
        self.jdConfigInit()
    }
    
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return self.selectedViewController
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
        #if TRACE_RESOURCES
            _ = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .subscribe(onNext: {_ in
                    print("Resource count \(Resources.total)")
                })
        #endif
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
