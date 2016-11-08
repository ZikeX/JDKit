//
//  CustomIBControl.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/8.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
@IBDesignable
class CustomIBControl: UIControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configInit() {
        
    }

}
