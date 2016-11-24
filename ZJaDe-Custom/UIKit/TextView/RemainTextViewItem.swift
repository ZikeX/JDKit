//
//  RemainTextViewItem.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class RemainTextViewItem: CustomIBControl {
    let textView:ComposeTextField = ComposeTextField()
    let remainLabel:UILabel = UILabel(color: Color.black, font: Font.h3)
    var maxLength:Int?
    override func configInit() {
        super.configInit()
        mainView.addSubview(self.textView)
        self.textView.edgesToView()
        mainView.addSubview(self.remainLabel)
        self.remainLabel.makeLayoutView { (view, maker) in
            maker.right.bottom.equalToSuperview()
        }
    }
}
