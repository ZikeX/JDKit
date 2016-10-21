//
//  JDButtonModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/3.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDButtonModel: JDFormModel {
    
    override func configModelInit() {
        super.configModelInit()
        spaceEdges = UIEdgeInsetsMake(8, 20, 8, 20)
        cellBackgroundColor = Color.clear
        cellContentHeight = 50
        
    }
    var buttonAppearanceClosure:ButtonAppearanceClosure = { (button) in
        button.backgroundColor = Color.tintColor
        button.cornerRadius = 5
        button.tintColor = Color.black
    }
    var buttonClick = PublishSubject<Void>()
}
