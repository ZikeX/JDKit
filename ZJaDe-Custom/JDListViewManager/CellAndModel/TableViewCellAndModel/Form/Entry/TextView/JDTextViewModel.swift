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
    
    override func configModelInit() {
        super.configModelInit()
    }
    var textViewAppearanceClosure:TextViewAppearanceClosure = { (textView) in
        textView.backgroundColor = Color.viewBackground
        textView.cornerRadius = 5
        textView.font = Font.h3
        textView.textColor = Color.black
    }
    var contentSizeChanged = PublishSubject<(PlaceholderTextView,CGSize)>()
    
    var configLayout:TextViewCellLayoutClosure = { (stackView,textView) in
        stackView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
        }
        textView.snp.makeConstraints({ (maker) in
            maker.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
            maker.bottom.lessThanOrEqualTo(textView.superview!)
            maker.height.equalTo(100)
        })
    }
}
