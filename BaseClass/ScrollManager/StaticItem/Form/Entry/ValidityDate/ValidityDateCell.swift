//
//  ValidityDateCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/11.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit

class ValidityDateCell: JDEntryCell {
    lazy var contentStackView:UIStackView = UIStackView(alignment: .fill, spacing: 8)
    lazy var firstTextField:TextFieldView = {
        let textField = self.createTextField()
        textField.entryType = .date(mode:.date)
        return textField
    }()
    lazy var label:UILabel = {
        let label = UILabel(text: "至", color: Color.black, font: Font.h3)
        label.contentHuggingHorizontalPriority = UILayoutPriorityRequired
        return label
    }()
    lazy var secondTextField:TextFieldView = {
        let textField = self.createTextField()
        textField.entryType = .date(mode:.date)
        return textField
    }()
    override func configItemInit() {
        super.configItemInit()
        stackView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
        }
        jdContentView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints { (maker) in
            maker.top.bottom.right.equalToSuperview()
            maker.leftSpace(stackView)
        }
        contentStackView.addArrangedSubview(firstTextField)
        contentStackView.addArrangedSubview(label)
        contentStackView.addArrangedSubview(secondTextField)
        secondTextField.snp.makeConstraints { (maker) in
            maker.width.equalTo(firstTextField)
        }
    }
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? ValidityDateModel else {
            return
        }
        binding(textField: firstTextField, model: model, index: 0)
        binding(textField: secondTextField, model: model, index: 1)
    }
}
extension ValidityDateCell {
    func createTextField() -> TextFieldView {
        let textField = TextFieldView(color: Color.black, font: Font.h3)
        textField.textAlignment = .center
        return textField
    }
}
