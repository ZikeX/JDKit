//
//  Alert+Prompt.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/5.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit



extension Alert {
    
    @discardableResult
    static func showPrompt(title:String = alertTitle, _ message:String, _ closure:AlertCancelClosure? = nil) -> Alert {
        let alert = Alert.content(title: title, message: message)
        alert.cancelButton.textStr = alertIKnowTitle
        alert.confirmButton.isHidden = true
        alert.configCancel(closure)
        alert.show()
        return alert
    }
    @discardableResult
    static func showChoice(title:String, _ message:String, _ closure:AlertCallBackClosure?, cancelClosure:AlertCancelClosure? = nil) -> Alert {
        let alert = Alert.content(title: title, message: message)
        alert.configClick(closure)
        alert.configCancel(cancelClosure)
        alert.show()
        return alert
    }
}
extension Alert {
    fileprivate static func content(title:String, message:String, isError:Bool = true) -> Alert {
        let alert = Alert()
        alert.bottomStackView.heightValue(height: 50)
        alert.titleButton.heightValue(height: 44)
        alert.titleButton.textStr = title
        alert.titleButton.textLabel.textColor = Color.white
        if isError {
            alert.titleButton.backgroundColor = Color.colorFromRGB("#ef6f56")
        }else {
            alert.titleButton.backgroundColor = Color.colorFromRGB("#4ebe22")
        }
        alert.confirmButton.textLabel.textColor = Color.colorFromRGB("#4ebe22")
        
        alert.configShowLayout { (alert, contentView) in
            // MARK: -
            contentView.snp.makeConstraints({ (maker) in
                maker.width.equalTo(jd.screenWidth * 0.75)
                maker.height.greaterThanOrEqualTo(80)
            })
            contentView.backgroundColor = Color.viewBackground
            // MARK: - 
            let imageView = ImageView()
            if isError {
                imageView.image = R.image.ic_alert_叹号()
            }else {
                imageView.image = R.image.ic_alert_笑脸()
            }
            contentView.addSubview(imageView)
            imageView.snp.makeConstraints({ (maker) in
                maker.centerX.equalToSuperview()
                maker.centerY.equalTo(contentView.snp.top)
            })
            // MARK: -
            let label = UILabel(text: message, color: Color.black, font: Font.h3)
            label.numberOfLines = 0
            label.textAlignment = .center
            contentView.addSubview(label)
            label.snp.makeConstraints({ (maker) in
                maker.centerX.equalToSuperview()
                maker.left.greaterThanOrEqualToSuperview().offset(20)
                maker.top.equalToSuperview().offset(30)
                maker.bottom.lessThanOrEqualToSuperview().offset(-20)
            })
        }
        return alert
    }
}
