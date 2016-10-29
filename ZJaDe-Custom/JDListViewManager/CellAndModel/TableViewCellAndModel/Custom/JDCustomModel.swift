//
//  JDCustomModel.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDCustomModel: JDTableViewModel {
    override func configModelInit() {
        super.configModelInit()
        isNibCell = true
        self.spaceEdges = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
