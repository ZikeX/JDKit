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
    static func showPrompt(title:String? = nil, _ content:String, _ closure:AlertCancelClosure? = nil) -> Alert {
        let alert = Alert.content(itemArr:nil,title: title, content: content)
        alert.cancelButton.textStr = "知道了"
        alert.configCancel(closure)
        alert.show()
        return alert
    }
    @discardableResult
    static func showChoice(title:String, _ content:String,buttonTitle:String = "确定", _ closure:AlertCallBackClosure? = nil) -> Alert {
        let alert = Alert.content(itemArr:[buttonTitle], title: title, content: content)
        alert.configClick(closure)
        alert.show()
        return alert
    }
}
extension Alert {
    fileprivate static func content(itemArr:[String]? = ["确定"],title:String?,content:String) -> Alert {
        let alert = Alert(itemTitleArray: itemArr)
        alert.baseView.backgroundColor = Color.white.alpha(0.85)
        alert.bottomStackView.addBorderTop()
        alert.bottomStackView.arrangedSubviews.dropLast().forEach { (view) in
            view.addBorderRight(fixedLength:20)
        }
        alert.bottomStackView.heightValue(height: 44)
        alert.titleButton.textStr = title ?? "你好！"
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
