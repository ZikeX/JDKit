//
//  JDButtonModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/3.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDButtonModel: JDFormModel {
    
    override func configModelInit() {
        super.configModelInit()
        cellHeight = 64
        
        spaceEdges = UIEdgeInsetsMake(8, 20, 8, 20)
    }
    var buttonClick = PublishSubject<Void>()
}
