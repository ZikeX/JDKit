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
    
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = textField
        jdContentView.addSubview(textField)
        
        stackView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints({ (maker) in
            maker.centerY.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(0)
        })
    }
}
extension JDTextFieldCell {
    override func configItem(_ model: JDTableModel) {
        super.configItem(model)
        guard let model = model as? JDTextFieldModel else {
            return
        }
        textField.snp.updateConstraints { (maker) in
            maker.leftSpace(stackView).offset(model.titleRightSpace)
        }
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDTextFieldModel else {
            return
        }
        textField.entryType = model.entryType
        self.configTextField(textField)
        
        self.binding(textField: textField, model: model, index: 0)
        
        controlEvents(textField: textField, editingState: model.textFieldEditingState)
    }
    func configTextField(_ textField:ComposeTextField) {
        textField.backgroundColor = Color.clear
        textField.textColor = Color.black
        textField.font = Font.h3
    }
    override func updateEnabledState(_ model: JDTableModel, enabled: Bool) {
        super.updateEnabledState(model, enabled: enabled)
        self.textField.isEnabled = enabled
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

