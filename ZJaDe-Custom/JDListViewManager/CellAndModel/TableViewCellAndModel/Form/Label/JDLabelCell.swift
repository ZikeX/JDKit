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
        
        stackView.snp.makeConstraints { (maker) in
            maker.top.centerY.equalToSuperview()
        }
        detailTitleLabel.snp.makeConstraints({ (maker) in
            maker.centerY.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
        })
        detailTitleLabel.contentHuggingHorizontalPriority = 249
    }
}
extension JDLabelCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let labelModel = model as? JDLabelModel else {
            return
        }
        labelModel.detailTitle.asObservable().bindTo(detailTitleLabel.rx.text).addDisposableTo(disposeBag)
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
