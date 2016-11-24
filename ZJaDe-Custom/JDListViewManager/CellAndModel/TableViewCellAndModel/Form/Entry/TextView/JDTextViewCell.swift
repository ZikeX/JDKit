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
        textView.snp.makeConstraints({ (maker) in
            maker.top.right.bottom.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
        })
    }
}
extension JDTextViewCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
    }
    
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDTextViewModel else {
            return
        }
        self.configTextView(textView)
        model.contentSizeChanged.bindTo(textView.contentSizeChanged).addDisposableTo(disposeBag)
        
        
        model.texts.first!.asObservable().bindTo(textView.rx.text).addDisposableTo(disposeBag)
        textView.rx.text.bindTo(model.texts.first!).addDisposableTo(disposeBag)
        
        model.entrys.first?.1.asObservable().subscribe(onNext: {[unowned self] (placeholder) in
            self.textView.placeholder = placeholder ?? ""
        }).addDisposableTo(disposeBag)
    }
    func configTextView(_ textView:PlaceholderTextView) {
        textView.backgroundColor = Color.viewBackground
        textView.cornerRadius = 5
        textView.font = Font.h3
        textView.textColor = Color.black
    }
}
