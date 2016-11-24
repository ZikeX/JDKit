//
//  ImageLabelItem.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class ImageLabelItem: CustomIBView {
    let stackView:UIStackView = UIStackView(alignment: .center, spacing: 8)
    let imageView:ImageView = ImageView()
    let label:UILabel = UILabel(color: Color.black, font: Font.h3)
    override func configInit() {
        super.configInit()
        self.addSubview(self.stackView)
        self.stackView.edgesToView()
        self.stackView.addArrangedSubview(self.imageView)
        self.stackView.addArrangedSubview(self.label)
        self.label.contentHuggingHorizontalPriority = UILayoutPriorityRequired
        self.imageView.makeLayoutView { (view, maker) in
            maker.top.equalTo(self.label.snp.firstBaseline)
            maker.bottom.equalTo(self.label.snp.lastBaseline)
        }
    }
}
