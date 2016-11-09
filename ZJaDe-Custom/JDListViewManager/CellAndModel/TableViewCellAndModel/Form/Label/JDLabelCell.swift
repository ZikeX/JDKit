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
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        guard let labelModel = element as? JDLabelModel else {
            return
        }
        labelModel.labelCellLayout(stackView,detailTitleLabel)
    }
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let labelModel = element as? JDLabelModel else {
            return
        }
        labelModel.detailTitle.asObservable().bindTo(detailTitleLabel.rx.text).addDisposableTo(disposeBag)
        labelModel.detailTitleLabelAppearanceClosure(detailTitleLabel)
    }
}
