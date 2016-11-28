//
//  JDOrderDataHeaderView.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDOrderDataHeaderView: BaseTableViewHeaderView {
    lazy var titleLabel = UILabel(text: "近一个月每日订单统计", color: Color.black, font: Font.h1)
    lazy var countLabel = UILabel(text: "?", color: Color.tintColor, font: Font.p40)
    lazy var averageLabel = UILabel(text: "每日平均 ?", color: Color.tintColor, font: Font.h4)
    
    override func configInit() {
        super.configInit()
        self.contentPriority(UILayoutPriorityRequired)
        self.countLabel.textAlignment = .center
        self.backgroundColor = Color.white
        self.addBorderBottom(boderWidth:5,color:Color.viewBackground)
    }
    
    override func configLayout() {
        self.addSubview(self.averageLabel)
        self.averageLabel.makeLayoutView { (_, maker) in
            maker.top.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
        }
        self.centerLayoutView.addSubview(self.titleLabel)
        self.centerLayoutView.addSubview(self.countLabel)
        self.titleLabel.makeLayoutView { (_, maker) in
            maker.left.centerX.top.equalToSuperview()
        }
        self.countLabel.makeLayoutView { (_, maker) in
            maker.left.centerX.bottom.equalToSuperview()
            maker.topSpace(self.titleLabel).offset(20)
        }
    }
    override var intrinsicContentSize: CGSize {
        let width = jd.screenWidth
        let height = width * 0.36
        return CGSize(width: width, height: height)
    }
}
