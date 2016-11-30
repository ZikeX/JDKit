//
//  JDEntryCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDEntryCell: JDFormCell {
    
}
extension JDEntryCell {
    func binding(textField:ComposeTextField,model:JDEntryModel,index:Int) {
        if index < model.texts.count {
            model.texts[index].asObservable()
                .bindTo(textField.rx.text)
                .addDisposableTo(disposeBag)
            textField.rx.text.bindTo(model.texts[index]).addDisposableTo(disposeBag)
        }
        if index < model.entrys.count {
            model.entrys[index].1.asObservable().subscribe(onNext: {[unowned textField] (placeholder) in
                textField.placeholder = placeholder
            }).addDisposableTo(disposeBag)
        }
    }
    func binding(titleTextField:TitleTextFieldItem,model:JDEntryModel,index:Int) {
        binding(textField: titleTextField.textField, model: model, index: index)
        if index < model.entrys.count {
            model.entrys[index].0.asObservable().subscribe(onNext: {[unowned titleTextField] (text) in
                titleTextField.titleLabel.text = text
            }).addDisposableTo(disposeBag)
        }
    }
}
extension JDEntryCell {
    func binding(textView:PlaceholderTextView,model:JDEntryModel,index:Int) {
        if index < model.texts.count {
            model.texts[index].asObservable()
                .bindTo(textView.rx.text)
                .addDisposableTo(disposeBag)
            textView.rx.text.bindTo(model.texts[index]).addDisposableTo(disposeBag)
        }
        if index < model.entrys.count {
            model.entrys[index].1.asObservable().subscribe(onNext: {[unowned textView] (placeholder) in
                textView.placeholder = placeholder ?? ""
            }).addDisposableTo(disposeBag)
        }
    }
    func binding(remainTextView:RemainTextViewItem,model:JDEntryModel,index:Int) {
        binding(textView: remainTextView.textView, model: model, index: index)
    }
}
