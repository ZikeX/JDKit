//
//  JDLabelCell.swift
//  JDTableViewExtensionDemo
//
//  Created by Z_JaDe on 16/8/28.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDLabelCell: JDFormCell {
    var detailTitleLabel = UILabel()
    
    override func configCellInit() {
        super.configCellInit()
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
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
        guard let model = model as? JDLabelModel else {
            return
        }
        detailTitleLabel.snp.remakeConstraints({ (maker) in
            maker.centerY.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(model.titleRightSpace)
        })
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDLabelModel else {
            return
        }
        model.detailTitle.asObservable().bindTo(detailTitleLabel.rx.text).addDisposableTo(disposeBag)
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
