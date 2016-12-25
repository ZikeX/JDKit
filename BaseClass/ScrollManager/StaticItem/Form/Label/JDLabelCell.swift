//
//  JDLabelCell.swift
//  TableViewExtensionDemo
//
//  Created by Z_JaDe on 16/8/28.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDLabelCell: JDFormCell {
    var detailTitleLabel = UILabel()
    
    override func configItemInit() {
        super.configItemInit()
        highlightAnimatedStyle = .shadow
        jdContentView.addSubview(detailTitleLabel)
        
        stackView.updateLayout.deactivate()
        stackView.updateLayout.constraintArr += stackView.snp.prepareConstraints { (maker) in
            maker.top.centerY.equalToSuperview()
        }
        stackView.updateLayout.activate()
        
        detailTitleLabel.contentHuggingHorizontalPriority = 249
    }
}
extension JDLabelCell {
    override func configItem(_ model: TableModel) {
        super.configItem(model)
        guard let model = model as? JDLabelModel else {
            return
        }
        detailTitleLabel.snp.remakeConstraints({ (maker) in
            maker.centerY.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(model.titleRightSpace)
        })
    }
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDLabelModel else {
            return
        }
        model.detailAttributeTitle.asObservable().subscribe(onNext:{ [unowned self](attributeText) in
            if attributeText != nil {
                self.detailTitleLabel.attributedText = attributeText
            }
        }).addDisposableTo(disposeBag)
        
        model.detailTitle.asObservable().asObservable().subscribe(onNext:{ [unowned self,unowned model](text) in
            if model.detailAttributeTitle.value == nil {
                self.detailTitleLabel.text = text
            }
        }).addDisposableTo(disposeBag)
        self.configDetailLabel(detailTitleLabel)
    }
}
extension JDLabelCell {
    func configDetailLabel(_ detailTitleLabel:UILabel) {
        detailTitleLabel.textColor = Color.gray
        detailTitleLabel.font = Font.h4
        detailTitleLabel.numberOfLines = 0
        detailTitleLabel.textAlignment = .right
    }
}
