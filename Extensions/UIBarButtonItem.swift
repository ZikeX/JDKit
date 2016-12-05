//
//  UIBarButtonItem+Rx.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

extension UIBarButtonItem {
    typealias ActionClosureType = (UIBarButtonItem)->()
    static func image(_ image:UIImage,_ closure:ActionClosureType?) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        _ = item.rx.tap.subscribe(onNext:{[unowned item] (_) in
            closure?(item)
        })
        return item
    }
    static func title(_ title:String,_ closure:ActionClosureType?) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: title, style: .done, target: nil, action: nil)
        _ = item.rx.tap.subscribe(onNext:{[unowned item] (_) in
            closure?(item)
        })
        return item
    }
}
