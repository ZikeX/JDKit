//
//  CustomIBView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
@IBDesignable
class CustomIBView: UIView {

    override init(frame:CGRect = CGRect()) {
        super.init(frame:frame)
        self.configInit()
        self.viewDidLoad()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewDidLoad()
    }
    func configInit() {
        self.isOpaque = false
        self.setNeedsUpdateConstraints()
        self.setNeedsLayout()
    }
    func viewDidLoad() {
        
    }

}
