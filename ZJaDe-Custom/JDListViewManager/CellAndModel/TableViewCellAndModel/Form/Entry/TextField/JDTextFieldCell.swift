//
//  JDTextFieldCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextFieldCell: JDEntryCell {
    var textField = ComposeTextField()
    
    override func configCellInit() {
        super.configCellInit()
        self.jdFocusView = textField
        jdContentView.addSubview(textField)
        
        stackView.snp.makeConstraints { (maker) in
            maker.top.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints({ (maker) in
            maker.centerY.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
        })
    }
}
extension JDTextFieldCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
        
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDTextFieldModel else {
            return
        }
        textField.entryType = model.entryType
        self.configTextField(textField)
        model.text.asObservable()
            .bindTo(textField.rx.text)
            .addDisposableTo(disposeBag);
        textField.rx.text.bindTo(model.text).addDisposableTo(disposeBag)
        
        model.placeholder.asObservable().subscribe(onNext: {[unowned self] (placeholder) in
            self.textField.placeholder = placeholder
        }).addDisposableTo(disposeBag)
        
        controlEvents(textField: textField, editingState: model.textFieldEditingState)
    }
    func configTextField(_ textField:ComposeTextField) {
        textField.backgroundColor = Color.white
        textField.textColor = Color.black
        textField.font = Font.h3
    }
}
extension JDTextFieldCell {
    func controlEvents(textField:ComposeTextField,editingState:PublishSubject<UIControlEvents>) {
        textField.rx.controlEvent(.editingDidBegin).subscribe(onNext: { (event) in
            editingState.onNext(.editingDidBegin)
            }).addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingChanged).subscribe(onNext: { (event) in
            editingState.onNext(.editingChanged)
            }).addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingDidEnd).subscribe(onNext: { (event) in
            editingState.onNext(.editingDidEnd)
            }).addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { (event) in
            editingState.onNext(.editingDidEndOnExit)
            }).addDisposableTo(disposeBag)
    }
}

