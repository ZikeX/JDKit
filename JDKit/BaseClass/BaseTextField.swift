//
//  BaseTextField.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
enum TextFieldType {
    case BlackSearchBar
    case WhiteSearchBarWithCityButton
}
let defaultWidth:CGFloat = jd.screenWidth
let defaultHeight:CGFloat = 34

class BaseTextField: UITextField {
    var textFieldType:TextFieldType
    
    init(textFieldType:TextFieldType) {
        self.textFieldType = textFieldType
        super.init(frame: CGRect(x: 0, y: 0, width: defaultWidth, height: defaultHeight))
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configInit() {
        switch self.textFieldType {
        case .BlackSearchBar:
            self.isEnabled = false
            self.backgroundColor = Color.darkBlack.withAlphaComponent(0.2)
            self.addBorder()
            self.cornerRadius = 5
            self.leftView = UIImageView(image: R.image.ic_searchIcon()?.templateImage)
            self.leftView?.contentMode = .center
            self.leftView?.bounds = CGRect(x: 0, y: 0, width: defaultHeight, height: defaultHeight)
            self.leftViewMode = .always
            self.text = "目的地、景点、酒店、"
            self.textColor = Color.white
            self.font = Font.h4
        case .WhiteSearchBarWithCityButton:
            self.isEnabled = false
            self.addBorder()
            self.cornerRadius = defaultHeight / 2
            
            self.leftView = self.createWhiteLeftView()
            self.leftViewMode = .always
            
            self.rightView = UIImageView(image: R.image.ic_searchIcon()?.templateImage)
            self.rightView?.contentMode = .center
            self.rightView?.bounds = CGRect(x: 0, y: 0, width: defaultHeight * 1.5, height: defaultHeight)
            self.rightViewMode = .always
            
            self.text = "   目的地、景点、酒店、"
            self.textColor = Color.lightGray
            self.font = Font.h4
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: defaultWidth, height: defaultHeight)
    }
}
// MARK:  - WhiteSearchBarWithCityButton
extension BaseTextField {
    func createWhiteLeftView() -> UIView {
        let contentView = UIView(frame:CGRect(x: 0, y: 0, width: defaultHeight*2.3, height: defaultHeight))
        contentView.addBorderRight(padding: 7)
        let button = Button(title: "杭州", image: R.image.ic_location()?.templateImage)
        button.tintColor = Color.tintColor
        contentView.addSubview(button)
        button.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
            maker.right.equalToSuperview().offset(-10)
        }
        return contentView
    }
}
