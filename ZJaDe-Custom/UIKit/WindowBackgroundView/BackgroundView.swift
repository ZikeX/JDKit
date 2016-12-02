//
//  BackgroundView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class BackgroundView: CustomIBView {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundColor = Color.black.withAlphaComponent(0.3)
    }

}
