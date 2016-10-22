//
//  JDTextViewModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextViewModel: JDEntryModel {
    
    override func configModelInit() {
        super.configModelInit()
        autoAdjustHeight = true
    }
    var textViewAppearanceClosure:TextViewAppearanceClosure = { (textView) in
        textView.backgroundColor = Color.viewBackground
        textView.cornerRadius = 5
    }
    var contentSizeChanged = PublishSubject<(PlaceholderTextView,CGSize)>()
}