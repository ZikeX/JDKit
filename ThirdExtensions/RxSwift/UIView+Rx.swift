//
//  UIView+Rx.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

extension Reactive where Base:UIView {
    func whenTouch(_ closure:((Base)->())?) -> Disposable {
        return self.base.getTap().rx.event.subscribe(onNext:{ (tap) in
            closure?(tap.view as! Base)
        })
    }
}
