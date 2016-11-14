//
//  JDTextViewCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDTextViewCell: JDEntryCell {
    var textView = PlaceholderTextView()
    
    override func configCellInit() {
        super.configCellInit()
        self.jdFocusView = textView
        jdContentView.addSubview(textView)
        
    }
}
extension JDTextViewCell {
    override func configCell(_ model: JDTableViewModel) {
        super.configCell(model)
        guard let model = model as? JDTextViewModel else {
            return
        }
        model.configLayout(stackView,textView)
    }
    
    override func bindingModel(_ model: JDTableViewModel) {
        super.bindingModel(model)
        guard let model = model as? JDTextViewModel else {
            return
        }
        model.textViewAppearanceClosure(textView)
        model.contentSizeChanged.bindTo(textView.contentSizeChanged).addDisposableTo(disposeBag)
        
        model.text.asObservable().bindTo(textView.rx.text).addDisposableTo(disposeBag)
        textView.rx.text.bindTo(model.text).addDisposableTo(disposeBag)
        
        model.placeholder.asObservable().subscribe { (event) in
            self.textView.placeholder = event.element ?? ""
        }.addDisposableTo(disposeBag)
    }
}
