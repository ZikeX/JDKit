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
            maker.top.equalToSuperview()
        }
    }
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        textField.snp.makeConstraints({ (maker) in
            maker.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
            maker.bottom.lessThanOrEqualTo(jdContentView)
        })
    }
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let textFieldModel = element as? JDTextFieldModel else {
            return
        }
        textFieldModel.textFieldAppearanceClosure(textField)
        
        textFieldModel.text.asObservable().bindTo(textField.rx.text).addDisposableTo(disposeBag);
        textField.rx.text.bindTo(textFieldModel.text).addDisposableTo(disposeBag)
        
        textFieldModel.placeholder.asObservable().subscribe { (event) in
            self.textField.placeholder = event.element
        }.addDisposableTo(disposeBag)
        
        textField.rx.controlEvent(.editingDidBegin).subscribe { (event) in
            textFieldModel.textFieldEditingState.onNext(.editingDidBegin)
            }.addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingChanged).subscribe { (event) in
            textFieldModel.textFieldEditingState.onNext(.editingChanged)
            }.addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingDidEnd).subscribe { (event) in
            textFieldModel.textFieldEditingState.onNext(.editingDidEnd)
            }.addDisposableTo(disposeBag)
        textField.rx.controlEvent(.editingDidEndOnExit).subscribe { (event) in
            textFieldModel.textFieldEditingState.onNext(.editingDidEndOnExit)
            }.addDisposableTo(disposeBag)
    }

}

