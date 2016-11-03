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
        stackView.jdLayout.deactivate()
        if !labelModel.detailTitleIsEmpty {
            detailTitleLabel.jdLayout.deactivate()
        }
        
        switch labelModel.labelAlignment {
        case .center:
            stackView.jdLayout.centerYAlign(offset: 0).activate()
            if !labelModel.detailTitleIsEmpty {
                detailTitleLabel.jdLayout.centerYAlign(offset: 0).activate()
            }
        case .top:
            stackView.jdLayout.topAlign(offset: 0).activate()
            if !labelModel.detailTitleIsEmpty {
                detailTitleLabel.jdLayout.topAlign(offset: 0).activate()
            }
        }
        if !labelModel.detailTitleIsEmpty {
            detailTitleLabel.snp.makeConstraints({ (maker) in
                maker.right.equalToSuperview()
                maker.leftSpace(stackView, space: 8)
                maker.bottom.lessThanOrEqualTo(jdContentView)
            })
        }
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
