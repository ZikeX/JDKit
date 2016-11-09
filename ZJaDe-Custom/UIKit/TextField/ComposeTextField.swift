//
//  ComposeTextField.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/7.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

enum EntryType {
    case Phone
    case Email
    case Price
    case Count
    case Date
}

class ComposeTextField: UITextField {
    var prefix:String?
    var suffix:String?
    var entryType:EntryType? {
        didSet {
            switch entryType! {
            case .Phone:
                self.keyboardType = .phonePad
            case .Email:
                self.keyboardType = .emailAddress
            case .Price:
                self.keyboardType = .decimalPad
            case .Count:
                self.keyboardType = .numberPad
            case .Date:
                DatePicker().show(title: placeholder ?? "日期")
            }
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
