//
//  ComposeTextField.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/7.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

enum EntryType {
    case `default`
    case phone
    case email
    case price
    case number
    case count(min:Int?,max:Int?)
    case date(mode:UIDatePickerMode)
}

class ComposeTextField: UITextField {
    var prefix:String?
    var suffix:String?
    
    lazy var datePicker = UIDatePicker()
    
    var entryType:EntryType = .default {
        didSet {
            self.removeTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
            switch entryType {
            case .phone:
                self.keyboardType = .phonePad
            case .email:
                self.keyboardType = .emailAddress
            case .price:
                self.keyboardType = .decimalPad
            case .count,.number:
                self.keyboardType = .numberPad
            case .date(mode: _):
                self.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
            default:
                self.keyboardType = .default
            }
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.delegate = self
        self.clearButtonMode = .whileEditing
    }
}
extension ComposeTextField:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch self.entryType {
        case .date(mode:_):
            return false
        default:
            return true
        }
    }
    func showDatePicker() {
        switch self.entryType {
        case .date(mode:let mode):
            let format:String
            switch mode {
            case .date:
                format = "yyyy.MM.dd"
            case .time:
                format = "HH:mm"
            case .dateAndTime:
                format = "yyyy.MM.dd HH:mm"
            case .countDownTimer:
                format = "HH:mm:ss"
            }
            datePicker.datePickerMode = mode
            _ = datePicker.dateObservable.subscribe(onNext: {[unowned self] (date) in
                self.text = date.toString(format: format)
                self.sendActions(for: .editingChanged)
            });
            datePicker.show(title: placeholder ?? "日期")
        default:
            break
        }
    }
}
extension ComposeTextField {
    override func drawText(in rect: CGRect) {
        if prefix != nil || suffix != nil {
            let jdText = NSString(format: "%@%@%@", (prefix ?? ""),(text ?? ""),(suffix ?? ""))
            var attributes = [String:AnyObject]()
            attributes[NSFontAttributeName] = font
            attributes[NSForegroundColorAttributeName] = textColor
            
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = textAlignment
            paragraph.lineBreakMode = .byTruncatingTail
            attributes[NSParagraphStyleAttributeName] = paragraph
            var jdRect = rect
            jdRect.origin.y = (rect.size.height - jdText.size(attributes: attributes).height)/2
            jdText.draw(in: jdRect, withAttributes: attributes)
        }else {
            return super.drawText(in: rect)
        }
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return super.textRect(forBounds: bounds)
    }
}
