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
        
    }
}
extension JDLabelCell {
    override func configCell(_ model: JDTableViewModel) {
        super.configCell(model)
        guard let labelModel = model as? JDLabelModel else {
            return
        }
        labelModel.configLayout(stackView,detailTitleLabel)
    }
    override func bindingModel(_ model: JDTableViewModel) {
        super.bindingModel(model)
        guard let labelModel = model as? JDLabelModel else {
            return
        }
        labelModel.detailTitle.asObservable().bindTo(detailTitleLabel.rx.text).addDisposableTo(disposeBag)
        labelModel.detailTitleLabelAppearanceClosure(detailTitleLabel)
    }
}
