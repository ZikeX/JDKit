//
//  JDPickerViewComponentModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDPickerViewComponentModel: NSObject {
    var attStrArr = [NSAttributedString]()
    var strArr = [String]() {
        didSet {
            attStrArr = strArr.map { (str) -> NSAttributedString in
                return NSAttributedString(string: str)
            }
        }
    }
    var width:CGFloat = 0
}
