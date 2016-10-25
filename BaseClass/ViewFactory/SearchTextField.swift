//
//  SearchTextField.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
enum TextFieldType {
    case BlackSearchBar
    case ClearWhiteSearchBarWithCityButton
    case LightWhiteSearchBarWithCityButton
}
let defaultWidth:CGFloat = jd.screenWidth
let defaultHeight:CGFloat = 34

class SearchTextField: UITextField {
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
        self.isEnabled = false
        self.addBorder()
        self.font = Font.h4
        
        switch self.textFieldType {
        case .BlackSearchBar:
            self.configBlackSearchBar()
        case .ClearWhiteSearchBarWithCityButton:
            self.configClearWhiteSearchBarWithCityButton()
        case .LightWhiteSearchBarWithCityButton:
            self.configLightWhiteSearchBarWithCityButton()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: defaultWidth, height: defaultHeight)
    }
}
// MARK:  -
extension SearchTextField {
    func configBlackSearchBar() {
        self.backgroundColor = Color.darkBlack.withAlphaComponent(0.2)
        self.cornerRadius = 5
        self.leftView = UIImageView(image: R.image.ic_searchIcon()?.templateImage)
        self.leftView?.contentMode = .center
        self.leftView?.bounds = CGRect(x: 0, y: 0, width: defaultHeight, height: defaultHeight)
        self.leftViewMode = .always
        self.textColor = Color.white
    }
}
extension SearchTextField {
    func configClearWhiteSearchBarWithCityButton() {
        
        self.cornerRadius = defaultHeight / 2
        
        self.leftView = {
            let contentView = UIView(frame:CGRect(x: 0, y: 0, width: defaultHeight*2.3, height: defaultHeight))
            contentView.addBorderRight(padding: 7)
            let button = Button(title: "杭州", image: R.image.ic_location()?.templateImage)
            button.textLabel.font = Font.h3
            button.tintColor = Color.tintColor
            contentView.addSubview(button)
            button.snp.makeConstraints { (maker) in
                maker.centerY.equalToSuperview()
                maker.right.equalToSuperview().offset(-10)
            }
            return contentView
        }()
        self.leftViewMode = .always
        
        self.rightView = UIImageView(image: R.image.ic_searchIcon()?.templateImage)
        self.rightView?.contentMode = .center
        self.rightView?.bounds = CGRect(x: 0, y: 0, width: defaultHeight * 1.5, height: defaultHeight)
        self.rightViewMode = .always
        self.textColor = Color.lightGray
    }
}
extension SearchTextField {
    func configLightWhiteSearchBarWithCityButton() {
        self.cornerRadius = 5
        self.backgroundColor = Color.white.withAlphaComponent(0.8)
        
        self.leftView = {
            let contentView = UIView(frame:CGRect(x: 0, y: 0, width: defaultHeight*2.3, height: defaultHeight))
            contentView.addBorderRight(color:Color.white,padding: 7)
            let button = Button(title: "杭州", image: R.image.ic_location()?.templateImage)
            button.textLabel.font = Font.h3
            button.tintColor = Color.tintColor
            contentView.addSubview(button)
            button.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
            }
            return contentView
        }()
        self.leftViewMode = .always
        
        self.rightView = UIImageView(image: R.image.ic_searchIcon()?.templateImage)
        self.rightView?.tintColor = Color.black
        self.rightView?.contentMode = .center
        self.rightView?.bounds = CGRect(x: 0, y: 0, width: defaultHeight * 1.5, height: defaultHeight)
        self.rightViewMode = .always
        
        self.textColor = Color.lightGray
    }
}
