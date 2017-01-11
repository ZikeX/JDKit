//
//  TextFieldView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum EntryType {
    case `default`
    case phone
    case email
    case price
    case number
    case count(min:Int?,max:Int?)
    case date(mode:UIDatePickerMode)
    case birthday
}

class TextFieldView: CustomIBView {
    convenience init(text:String? = nil,placeholder:String? = nil,color:UIColor,font:UIFont) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.textColor = color
        self.font = font
    }
    
    let textField = ComposeTextField()

    lazy var datePicker = UIDatePicker()
    fileprivate var datePickerDisposeBag = DisposeBag()
    
    var entryType:EntryType = .default {
        didSet {
            self.textField.isUserInteractionEnabled = true
            datePickerDisposeBag = DisposeBag()
            switch entryType {
            case .phone:
                self.textField.keyboardType = .phonePad
            case .email:
                self.textField.keyboardType = .emailAddress
            case .price:
                self.textField.keyboardType = .decimalPad
            case .count,.number:
                self.textField.keyboardType = .numberPad
            case .date(mode: _), .birthday:
                self.textField.isUserInteractionEnabled = false
                self.rx.whenTouch({[unowned self] (textView) in
                    self.showDatePicker()
                }).addDisposableTo(datePickerDisposeBag)
                self.textField.keyboardType = .default
            default:
                self.textField.keyboardType = .default
            }
        }
    }
    override func configInit() {
        super.configInit()
        self.addSubview(self.textField)
        self.textField.font = Font.h3
        self.textField.textColor = Color.black
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textField.frame = self.bounds
    }
}
extension TextFieldView {
    @IBInspectable var text:String? {
        get {return self.textField.text}
        set {self.textField.text = newValue}
    }
    @IBInspectable var placeholder:String? {
        get {return self.textField.placeholder}
        set {self.textField.placeholder = newValue}
    }
    @IBInspectable var textColor:UIColor? {
        get {return self.textField.textColor}
        set {self.textField.textColor = newValue}
    }
    @IBInspectable var font:UIFont? {
        get {return self.textField.font}
        set {self.textField.font = newValue}
    }
    @IBInspectable var leftView:UIView? {
        get {return self.textField.leftView}
        set {self.textField.leftView = newValue}
    }
    @IBInspectable var leftViewMode:UITextFieldViewMode {
        get {return self.textField.leftViewMode}
        set {self.textField.leftViewMode = newValue}
    }
    @IBInspectable var rightView:UIView? {
        get {return self.textField.rightView}
        set {self.textField.rightView = newValue}
    }
    @IBInspectable var rightViewMode:UITextFieldViewMode {
        get {return self.textField.rightViewMode}
        set {self.textField.rightViewMode = newValue}
    }
    @IBInspectable var textAlignment:NSTextAlignment {
        get {return self.textField.textAlignment}
        set {self.textField.textAlignment = newValue}
    }
    @IBInspectable var isEnabled:Bool {
        get {return self.textField.isEnabled}
        set {self.textField.isEnabled = newValue}
    }
    @IBInspectable var clearButtonMode:UITextFieldViewMode {
        get {return self.textField.clearButtonMode}
        set {self.textField.clearButtonMode = newValue}
    }
    @IBInspectable var isSecureTextEntry:Bool {
        get {return self.textField.isSecureTextEntry}
        set {self.textField.isSecureTextEntry = newValue}
    }
    
}
extension Reactive where Base: TextFieldView {
    var text: ControlProperty<String?> {
        get {return base.textField.rx.text}
    }
}
extension TextFieldView {
    func showDatePicker() {
        guard !self.datePicker.isShowing else {
            return
        }
        let dateMode:UIDatePickerMode
        let format:String
        let dateAlertTitle:String
        switch self.entryType {
        case .date(mode:let mode):
            switch mode {
            case .date:
                format = "yyyy-MM-dd"
            case .time:
                format = "HH:mm"
            case .dateAndTime:
                format = "yyyy-MM-dd HH:mm"
            case .countDownTimer:
                format = "HH:mm:ss"
            }
            dateMode = mode
            dateAlertTitle = placeholder ?? "日期"
            datePicker.minimumDate = Date()
            datePicker.maximumDate = nil
        case .birthday:
            dateMode = .date
            format = "yyyy-MM-dd"
            dateAlertTitle = "选择生日"
            datePicker.minimumDate = nil
            datePicker.maximumDate = Date()
        default:
            return
        }
        datePicker.dateObservable.subscribe(onNext: {[unowned self] (date) in
            self.text = date.toString(format: format)
            self.textField.sendActions(for: .editingChanged)
        }).addDisposableTo(datePickerDisposeBag)
        datePicker.datePickerMode = dateMode
        datePicker.show(title: dateAlertTitle)
    }
}
