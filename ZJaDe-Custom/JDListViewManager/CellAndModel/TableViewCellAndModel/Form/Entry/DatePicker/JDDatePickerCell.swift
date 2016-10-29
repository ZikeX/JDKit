//
//  JDDatePickerCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDDatePickerCell: JDTextFieldCell {
    var datePicker = UIDatePicker()
    
    override func configCellInit() {
        super.configCellInit()
        textField.inputView = self.datePicker
    }
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let datePickerModel = element as? JDDatePickerModel else {
            return
        }
        datePickerModel.datePickerAppearanceClosure?(datePicker)
        if datePickerModel.dateFormat == nil {
            datePickerModel.dateFormat = {
                switch datePicker.datePickerMode {
                case .date:
                    return "yyyy-MM-dd"
                case .time:
                    return "HH:mm:ss"
                case .dateAndTime:
                    return "yyyy-MM-dd HH:mm"
                case .countDownTimer:
                    return "HH:mm"
                }
            }()
        }
        
        textField.rx.controlEvent(.editingDidBegin).subscribe { (event) in
            self.setTextFieldText(datePickerModel)
        }.addDisposableTo(disposeBag)
        
        datePicker.rx.date.subscribe { (event) in
            self.setTextFieldText(datePickerModel)
        }.addDisposableTo(disposeBag)
    }
    
}
extension JDDatePickerCell {
    func setTextFieldText(_ datePickerModel:JDDatePickerModel) {
        let formatter = DateFormatter()
        formatter.dateFormat = datePickerModel.dateFormat
        let dateStr = formatter.string(from: datePicker.date)
        textField.text = dateStr
    }
}
