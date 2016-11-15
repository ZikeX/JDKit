//
//  JDDoubleTextFieldCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDDoubleTextFieldCell: JDTextFieldCell {
    var intervalLabel = UILabel()
    var secondTextField = ComposeTextField()
    
    override func configCellInit() {
        super.configCellInit()
        jdContentView.addSubview(intervalLabel)
        jdContentView.addSubview(secondTextField)
        
        [textField,intervalLabel,secondTextField].forEach { (view) in
            view.snp.remakeConstraints { (maker) in
                maker.top.centerY.equalToSuperview()
            }
        }
        textField.snp.makeConstraints({ (maker) in
            maker.leftSpace(stackView).offset(8)
        })
        intervalLabel.snp.makeConstraints({ (maker) in
            maker.leftSpace(textField).offset(8)
        })
        intervalLabel.contentHuggingHorizontalPriority = UILayoutPriorityRequired
        secondTextField.snp.makeConstraints({ (maker) in
            maker.right.equalToSuperview()
            maker.width.equalTo(textField)
            maker.leftSpace(intervalLabel).offset(8)
        })
    }
}
extension JDDoubleTextFieldCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDDoubleTextFieldModel else {
            return
        }
        intervalLabel.textColor = titleLabel.textColor
        intervalLabel.font = titleLabel.font
        intervalLabel.text = model.intervalText
        
        secondTextField.entryType = model.entryType
        configTextField(secondTextField)
        
        model.secondText.asObservable()
            .bindTo(secondTextField.rx.text)
            .addDisposableTo(disposeBag);
        secondTextField.rx.text.bindTo(model.secondText).addDisposableTo(disposeBag)
        
        model.secondPlaceholder.asObservable().subscribe { (event) in
            self.secondTextField.placeholder = event.element
            }.addDisposableTo(disposeBag)
        
        controlEvents(textField: secondTextField, editingState: model.secondTextFieldEditingState)
    }
}
extension JDDoubleTextFieldCell {
    override func configTextField(_ textField:ComposeTextField) {
        super.configTextField(textField)
        textField.textAlignment = .center
    }
}
