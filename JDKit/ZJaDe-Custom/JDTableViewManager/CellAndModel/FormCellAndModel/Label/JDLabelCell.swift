//
//  JDLabelCell.swift
//  JDTableViewExtensionDemo
//
//  Created by Z_JaDe on 16/8/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDLabelCell: JDFormCell {
    var detailTitleLabel = UILabel()
    
    override func configCellInit() {
        super.configCellInit()
        jdContentView.addSubview(detailTitleLabel)
        stackView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview()
            maker.bottom.lessThanOrEqualTo(jdContentView)
        }
    }
    override func cellDidLoad(_ element: JDElementModel) {
        super.cellDidLoad(element)
        guard let labelModel = element as? JDLabelModel else {
            return
        }
        if !labelModel.detailTitleIsEmpty {
            detailTitleLabel.snp.makeConstraints({ (maker) in
                maker.top.right.equalToSuperview()
                maker.left.equalTo(stackView.snp.right).offset(8)
                maker.bottom.lessThanOrEqualTo(jdContentView)
            })
        }
    }
    override func configCellWithElement(_ element: JDElementModel) {
        super.configCellWithElement(element)
        guard let labelModel = element as? JDLabelModel else {
            return
        }
        labelModel.detailTitle.asObservable().bindTo(detailTitleLabel.rx.text).addDisposableTo(disposeBag)
        labelModel.detailTitleLabelAppearanceClosure(detailTitleLabel)
    }
}
