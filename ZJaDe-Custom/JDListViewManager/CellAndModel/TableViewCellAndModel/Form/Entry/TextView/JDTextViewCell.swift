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
        stackView.snp.makeConstraints { (maker) in
            maker.top.equalToSuperview()
        }
    }
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        textView.snp.makeConstraints({ (maker) in
            maker.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
            maker.bottom.lessThanOrEqualTo(jdContentView)
            maker.height.equalTo(100)
        })
    }
    
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let textViewModel = element as? JDTextViewModel else {
            return
        }
        textViewModel.textViewAppearanceClosure(textView)
        textViewModel.contentSizeChanged.bindTo(textView.contentSizeChanged).addDisposableTo(disposeBag)
        
        textViewModel.text.asObservable().bindTo(textView.rx.text).addDisposableTo(disposeBag)
        textView.rx.text.bindTo(textViewModel.text).addDisposableTo(disposeBag)
        
        textViewModel.placeholder.asObservable().subscribe { (event) in
            self.textView.placeholder = event.element ?? ""
        }.addDisposableTo(disposeBag)
    }
}
