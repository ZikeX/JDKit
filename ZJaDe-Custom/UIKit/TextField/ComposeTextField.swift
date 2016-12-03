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
        
    }
}
extension ComposeTextField:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch self.entryType ?? .default {
        case .date(mode: let mode):
            jd.endEditing()
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
            format = "HH:mm"
        case .dateAndTime:
            format = "yyyy.MM.dd HH:mm"
        case .countDownTimer:
            format = "HH:mm:ss"
        }
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = mode
        _ = datePicker.dateObservable.subscribe(onNext: {[unowned self] (date) in
            self.text = date.toString(format: format)
            self.sendActions(for: .valueChanged)
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
