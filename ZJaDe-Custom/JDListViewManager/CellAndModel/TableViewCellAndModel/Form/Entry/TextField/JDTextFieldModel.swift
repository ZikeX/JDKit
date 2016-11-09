//
//  JDTextFieldModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextFieldModel: JDEntryModel {
    
    override func configModelInit() {
        super.configModelInit()
        self.cellHeight = 45
    }
    
    var textFieldAppearanceClosure:TextFieldAppearanceClosure = { (textField) in
        textField.backgroundColor = Color.viewBackground
        textField.cornerRadius = 5
        textField.addBorder()
    }
    var textFieldEditingState = PublishSubject<UIControlEvents>()
    
    var textFieldCellLayout:TextFieldCellLayoutClosure = { (stackView,textField) in
        stackView.snp.makeConstraints { (maker) in
            maker.top.centerY.equalToSuperview()
        }
        textField.snp.makeConstraints({ (maker) in
            maker.centerY.top.right.equalToSuperview()
            maker.leftSpace(stackView).offset(8)
        })
    }
}

