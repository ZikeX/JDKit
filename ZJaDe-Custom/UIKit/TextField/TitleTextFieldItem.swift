//
//  TitleTextFieldItem.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class TitleTextFieldItem: CustomIBControl {
    let stackView:UIStackView = UIStackView(alignment: .fill, spacing: 8)
    let textField:ComposeTextField = ComposeTextField(color: Color.black, font: Font.h3)
    let titleLabel:UILabel = UILabel(color: Color.black, font: Font.h3)
    override func configInit() {
        super.configInit()
        mainView.addSubview(self.stackView)
        self.stackView.edgesToView()
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.textField)
        self.titleLabel.contentHuggingHorizontalPriority = UILayoutPriorityRequired
    }
}
