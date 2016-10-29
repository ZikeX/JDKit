
//
//  PlaceholderTextView.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class PlaceholderTextView: UITextView {
    var placeholder = "" {
        didSet {
            self.setNeedsDisplay()

        }
    }
    var attributedPlaceholder:NSAttributedString? {
        didSet {
    
            self.setNeedsDisplay()
        }
    }
    var contentSizeChanged = PublishSubject<(PlaceholderTextView,CGSize)>()
    override var contentSize: CGSize {
        didSet {
            contentSizeChanged.onNext((self,contentSize))
        }
    }
    
    /*************** init ***************/
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    override init(frame: CGRect = CGRect(), textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.initialize()
    }
    func initialize() {
        NotificationCenter.default.addObserver(self, selector: #selector(PlaceholderTextView.textChanged(_:)), name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    func textChanged(_ notification:Notification) {
        self.setNeedsDisplay()
    }
}
extension PlaceholderTextView {//placeholder扩展
    override var text: String! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    override func insertText(_ text: String) {
        super.insertText(text)
        self.setNeedsDisplay()
    }
    override var attributedText: NSAttributedString! {
        didSet {
            self.setNeedsDisplay()
        }
    }
    override var textContainerInset: UIEdgeInsets {
        didSet {
            self.setNeedsDisplay()
        }
        
    }
    override var font: UIFont? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    override var textAlignment: NSTextAlignment {
        didSet {
            self.setNeedsDisplay()
        }
    }
    /*************** drawRect ***************/
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if self.text.characters.count == 0 {
            var attributedStr:NSAttributedString?
            if self.attributedPlaceholder != nil {
                attributedStr = self.attributedPlaceholder
            }else {
                var attributes = [String : AnyObject]()
                attributes[NSFontAttributeName] = self.font
                attributes[NSForegroundColorAttributeName] = Color.placeholder
                if self.textAlignment != .left {
                    let paragraph = NSMutableParagraphStyle()
                    paragraph.alignment = self.textAlignment
                    attributes[NSParagraphStyleAttributeName] = paragraph
                }
                //                if self.isFirstResponder() && self.typingAttributes.count > 0 {
                //                    for (str,obj) in self.typingAttributes {
                //                        attributes[str] = obj
                //                    }
                //                }
                attributedStr = NSAttributedString(string: self.placeholder, attributes: attributes)
                let placeholderRect = self.placeholderRectForBounds(self.bounds)
                attributedStr?.draw(in: placeholderRect)
            }
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.text.characters.count == 0 && (self.placeholder.characters.count > 0 || self.attributedPlaceholder != nil) {
            self.setNeedsDisplay()
        }
    }
    func placeholderRectForBounds(_ bounds:CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset)
        let padding = self.textContainer.lineFragmentPadding
        rect.origin.x += padding
        rect.size.width -= padding * 2.0
        return rect
    }
}
