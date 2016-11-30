//
//  JDTextViewCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDTextViewCell: JDEntryCell {
    lazy var textViewItem:RemainTextViewItem = RemainTextViewItem()
    
    override func configCellInit() {
        super.configCellInit()
        self.jdFocusView = textViewItem
        jdContentView.addSubview(textViewItem)
    }
}
extension JDTextViewCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
        guard let model = model as? JDTextViewModel else {
            return
        }
        textViewItem.snp.remakeConstraints({ (maker) in
            maker.top.right.bottom.equalToSuperview()
            maker.leftSpace(stackView).offset(model.titleRightSpace)
        })
    }
    
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDTextViewModel else {
            return
        }
        textViewItem.maxLength = model.maxLength
        self.configTextView(textViewItem.textView)
        model.contentSizeChanged.bindTo(textViewItem.textView.contentSizeChanged).addDisposableTo(disposeBag)
        
        self.binding(remainTextView: textViewItem, model: model, index: 0)
    }
    func configTextView(_ textView:PlaceholderTextView) {
        textView.backgroundColor = Color.viewBackground
        textView.cornerRadius = 5
        textView.font = Font.h3
        textView.textColor = Color.black
    }
    override func updateEnabledState(_ model: JDTableModel, enabled: Bool) {
        super.updateEnabledState(model, enabled: enabled)
        self.textViewItem.textView.isEditable = enabled
    }
}
