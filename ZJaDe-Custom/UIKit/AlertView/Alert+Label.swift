//
//  Alert+Label.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/5.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension Alert {
    @discardableResult
    static func prompt(title:String,content:String,closure:@escaping (Int)->()) -> Alert {
        let alert = Alert.content(itemArr:nil,title: title, content: content)
        alert.cancelButton.textStr = "知道了"
        alert.configClick(closure)
        return alert
    }
    @discardableResult
    static func warning(title:String,content:String,closure:@escaping (Int)->()) -> Alert {
        let alert = Alert.content(title: title, content: content)
        alert.configClick(closure)
        return alert
    }
}
extension Alert {
    fileprivate static func content(itemArr:[String]? = ["确定"],title:String,content:String) -> Alert {
        let alert = Alert(itemTitleArray: itemArr)
        alert.baseView.backgroundColor = Color.white.withAlphaComponent(0.85)
        alert.bottomStackView.addBorderTop()
        alert.bottomStackView.arrangedSubviews.dropLast().forEach { (view) in
            view.addBorderRight(padding:-20)
        }
        alert.bottomStackView.heightValue(height: 44)
        alert.titleButton.textStr = title
        alert.configShowLayout { (alert, contentView) in
            contentView.snp.makeConstraints({ (maker) in
                maker.width.equalTo(jd.screenWidth * 0.75)
                maker.height.greaterThanOrEqualTo(50)
            })
            let label = UILabel(text: content, color: Color.black, font: Font.h3)
            label.numberOfLines = 0
            label.textAlignment = .center
            contentView.addSubview(label)
            label.snp.makeConstraints({ (maker) in
                maker.edges.equalToSuperview().inset(UIEdgeInsetsMake(0, 20, 0, 20))
            })
        }
        return alert
    }
}
