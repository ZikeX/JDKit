//
//  JDDatePickerModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDDatePickerModel: JDTextFieldModel {
    
    var dateFormat: String?
    
    var datePickerAppearanceClosure:DatePickerAppearanceClosure?
    
    override func configModelInit() {
        super.configModelInit()
        let oldClosure = textFieldAppearanceClosure
        textFieldAppearanceClosure = { (textField) in
            oldClosure(textField)
            textField.clearButtonMode = .never
            textField.leftViewMode = .never
            textField.rightViewMode = .never
        }
    }
}
