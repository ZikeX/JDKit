//
//  JDTextViewModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextViewModel: JDEntryModel {
    var maxLength:Int?
    
    override func configModelInit() {
        super.configModelInit()
        self.cellHeight = 110
    }
    var contentSizeChanged = PublishSubject<(PlaceholderTextView,CGSize)>()
}
