//
//  JDDoubleTextFieldCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/9.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDDoubleTextFieldCell: JDTextFieldCell {
    var intervalLabel = UILabel()
    var secondTextField = ComposeTextField()
    
    override func configCellInit() {
        super.configCellInit()
        let mainStackView = UIStackView(alignment: .fill, spacing: 8)
        jdContentView.addSubview(mainStackView)
        mainStackView.snp.makeConstraints { (maker) in
            maker.leftSpace(self.stackView).offset(8)
            
            maker.top.bottom.right.equalToSuperview()
        }
        textField.removeFromSuperview()
        mainStackView.addArrangedSubview(textField)
        mainStackView.addArrangedSubview(intervalLabel)
        mainStackView.addArrangedSubview(secondTextField)
        
        intervalLabel.contentHuggingHorizontalPriority = UILayoutPriorityRequired
        secondTextField.snp.makeConstraints({ (maker) in
            maker.width.equalTo(textField)
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
        
        secondTextField.entryType = model.secondEntryType ?? model.entryType
        configTextField(secondTextField)
        
        model.secondText.asObservable()
            .bindTo(secondTextField.rx.text)
            .addDisposableTo(disposeBag);
        secondTextField.rx.text.bindTo(model.secondText).addDisposableTo(disposeBag)
        
        model.secondPlaceholder.asObservable().subscribe(onNext: {[unowned self] (placeholder) in
            self.secondTextField.placeholder = placeholder
            }).addDisposableTo(disposeBag)
        
        controlEvents(textField: secondTextField, editingState: model.secondTextFieldEditingState)
    }
}
extension JDDoubleTextFieldCell {
    override func configTextField(_ textField:ComposeTextField) {
        super.configTextField(textField)
        textField.textAlignment = .center
    }
}
