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
    }
}
extension JDDoubleTextFieldCell {
    override func configCell(_ model: JDTableViewModel) {
        guard let textFieldModel = model as? JDDoubleTextFieldModel else {
            return
        }
        textFieldModel.configLayout = { (textField) in
            
        }
        super.configCell(model)
        textFieldModel.configDoubleTextFieldCellLayout(stackView,textField,intervalLabel,secondTextField)
    }
    override func bindingModel(_ model: JDTableViewModel) {
        super.bindingModel(model)
        guard let model = model as? JDDoubleTextFieldModel else {
            return
        }
        intervalLabel.textColor = titleLabel.textColor
        intervalLabel.font = titleLabel.font
        intervalLabel.text = model.intervalText
        
        secondTextField.entryType = model.entryType
        model.textFieldAppearanceClosure(secondTextField)
        
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
