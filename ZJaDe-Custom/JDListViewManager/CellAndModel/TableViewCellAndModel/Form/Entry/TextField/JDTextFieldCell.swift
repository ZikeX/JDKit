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
    }
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        guard let model = element as? JDTextFieldModel else {
            return
        }
        model.configLayout(stackView,textField)
    }
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let model = element as? JDTextFieldModel else {
            return
        }
        textField.entryType = model.entryType
        model.textFieldAppearanceClosure(textField)
        
        model.text.asObservable()
            .bindTo(textField.rx.text)
            .addDisposableTo(disposeBag);
        textField.rx.text.bindTo(model.text).addDisposableTo(disposeBag)
        
        model.placeholder.asObservable().subscribe { (event) in
            self.textField.placeholder = event.element
        }.addDisposableTo(disposeBag)
        
        controlEvents(textField: textField, editingState: model.textFieldEditingState)
    }
}
extension JDTextFieldCell {
    func controlEvents(textField:ComposeTextField,editingState:PublishSubject<UIControlEvents>) {
        textField.rx.controlEvent(.editingDidBegin).subscribe { (event) in
            editingState.onNext(.editingDidBegin)
            }.addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingChanged).subscribe { (event) in
            editingState.onNext(.editingChanged)
            }.addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingDidEnd).subscribe { (event) in
            editingState.onNext(.editingDidEnd)
            }.addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe { (event) in
            editingState.onNext(.editingDidEndOnExit)
            }.addDisposableTo(disposeBag)
    }
}

