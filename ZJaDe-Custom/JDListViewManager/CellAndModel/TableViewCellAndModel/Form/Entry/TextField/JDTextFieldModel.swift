//
//  JDTextFieldModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextFieldModel: JDEntryModel {
    var entryType:EntryType?
    
    override func configModelInit() {
        super.configModelInit()
        self.cellHeight = 45
    }
    var textFieldEditingState = PublishSubject<UIControlEvents>()
    
}

