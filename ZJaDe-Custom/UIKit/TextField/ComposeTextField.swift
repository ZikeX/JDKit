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
    case count
    case date(mode:UIDatePickerMode)
}

class ComposeTextField: UITextField {
    var prefix:String?
    var suffix:String?
    var entryType:EntryType? {
        didSet {
            switch entryType ?? .default {
            case .phone:
                self.keyboardType = .phonePad
            case .email:
                self.keyboardType = .emailAddress
            case .price:
                self.keyboardType = .decimalPad
            case .count:
                self.keyboardType = .numberPad
            default:
                self.keyboardType = .default
            }
        }
    }
    
    init() {
        super.init(frame: CGRect())
        self.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ComposeTextField:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch self.entryType ?? .default {
        case .date(mode: let mode):
            showDatePicker(mode: mode)
            return false
        default:
            return true
        }
    }
    func showDatePicker(mode: UIDatePickerMode) {
        let format:String
        switch mode {
        case .date:
            format = "yyyy.MM.dd"
        case .time:
            format = "HH:mm:ss"
        case .dateAndTime:
            format = "yyyy.MM.dd HH:mm"
        case .countDownTimer:
            format = "HH:mm"
        }
        let datePicker = DatePicker()
        datePicker.datePicker.datePickerMode = mode
        _ = datePicker.dateObservable.subscribe({ (event) in
            if let date = event.element {
                self.text = date.toString(format: format)
            }
        });
        datePicker.show(title: placeholder ?? "日期")
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
