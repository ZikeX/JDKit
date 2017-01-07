//
//  RemainTextViewItem.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class RemainTextViewItem: CustomIBControl {
    let textChanged:Variable<String?> = Variable(nil)
    let textView:PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.font = Font.h3
        textView.textColor = Color.black
        return textView
    }()
    let remainLabel:UILabel = UILabel(color: Color.gray, font: Font.h3)
    var maxLength:Int? {
        didSet {
            self.updateRemainLabel()
        }
    }
    override func configInit() {
        super.configInit()
        mainView.addSubview(self.textView)
        mainView.addSubview(self.remainLabel)
        self.textView.makeLayoutView { (view, maker) in
            maker.left.right.top.equalToSuperview()
            maker.bottomSpace(self.remainLabel)
        }
        self.remainLabel.makeLayoutView { (view, maker) in
            maker.right.bottom.equalToSuperview()
        }
        _ = self.textView.rx.text.asObservable().distinctUntilChanged{$0==$1}.bindTo(textChanged)
        
        _ = self.textChanged.asObservable().subscribe(onNext:{[unowned self] (text) in
            self.updateRemainLabel()
        })
    }
    func updateRemainLabel() {
        guard let maxLength = self.maxLength else {
            return
        }
        let text = self.textView.text ?? ""
        if text.length <= maxLength {
            self.remainLabel.text = "\(text.length)/\(maxLength)字"
            self.remainLabel.textColor = Color.gray
        }else {
            self.remainLabel.text = "您已超出\(text.length - maxLength)个字"
            self.remainLabel.textColor = Color.red
        }
    }
}
