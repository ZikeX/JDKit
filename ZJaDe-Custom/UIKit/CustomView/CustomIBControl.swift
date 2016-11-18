//
//  CustomIBControl.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
@IBDesignable
class CustomIBControl: UIControl,CustomIBProtocol {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configInit()
        self.viewDidLoad()
        self.configNeedUpdate()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewDidLoad()
        self.configNeedUpdate()
    }
    func configInit() {
        
    }
    func viewDidLoad() {
        
    }
}
