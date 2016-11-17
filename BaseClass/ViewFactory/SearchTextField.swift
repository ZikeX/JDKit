//
//  SearchTextField.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/29.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
enum TextFieldType {
    case boderSearchBar(searchIconInLeading:Bool)
    case clearWhiteSearchBarWithCity
    case lightWhiteSearchBarWithCity
}
let defaultWidth:CGFloat = jd.screenWidth
let defaultHeight:CGFloat = 34

class SearchTextField: UITextField {
    var textFieldType:TextFieldType? {
        didSet {
            self.updateTextFieldType()
        }
    }
    
    init(textFieldType:TextFieldType) {
        self.textFieldType = textFieldType
        super.init(frame: CGRect(x: 0, y: 0, width: defaultWidth, height: defaultHeight))
        self.configInit()
        self.updateTextFieldType()
        self.viewDidLoad()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewDidLoad()
    }
    
    func configInit() {
        self.isEnabled = false
        self.addBorder()
        self.font = Font.h4
        self.textColor = Color.lightGray
        self.backgroundColor = Color.clear
    }
    func viewDidLoad() {
        
    }

    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: defaultWidth, height: defaultHeight)
    }
    // MARK: -
    lazy var searchIconView:ImageView = {
        let icon = ImageView(image: R.image.ic_searchIcon()?.templateImage)
        icon.tintColor = Color.black
        icon.contentMode = .center
        icon.bounds = CGRect(x: 0, y: 0, width: defaultHeight, height: defaultHeight)
        return icon
    }()
    lazy var cityButton:Button = {
        let button = Button(title: "杭州", image: R.image.ic_location()?.templateImage)
        button.bounds = CGRect(x: 0, y: 0, width: defaultHeight*2.3, height: defaultHeight)
        button.textLabel.font = Font.h3
        button.tintColor = Color.tintColor
        return button
    }()
}
extension SearchTextField {
    func updateTextFieldType() {
        switch self.textFieldType {
        case .none:
            break
        case .boderSearchBar(searchIconInLeading: let isLeft)?:
            self.configBoderSearchBar(isLeft)
        case .clearWhiteSearchBarWithCity?:
            self.configClearWhiteSearchBarWithCity()
        case .lightWhiteSearchBarWithCity?:
            self.configLightWhiteSearchBarWithCity()
        }
    }
}
// MARK:  -
extension SearchTextField {
    func configBoderSearchBar(_ isLeft:Bool) {
        self.cornerRadius = 5
        if isLeft {
            self.leftView = self.searchIconView
            self.leftViewMode = .always
            self.rightView = nil
            self.rightViewMode = .never
        }else {
            self.leftView = nil
            self.leftViewMode = .never
            self.rightView = self.searchIconView
            self.rightViewMode = .always
        }
    }
}
extension SearchTextField {
    func configClearWhiteSearchBarWithCity() {
        
        self.cornerRadius = defaultHeight / 2
        
        self.leftView = self.cityButton
        self.leftView?.addBorderRight(padding: 7)
        self.leftViewMode = .always
        
        self.rightView = self.searchIconView
        self.rightView?.width = defaultHeight * 1.5
        self.rightViewMode = .always
    }
}
extension SearchTextField {
    func configLightWhiteSearchBarWithCity() {
        self.cornerRadius = 5
        self.backgroundColor = Color.white.withAlphaComponent(0.8)
        
        self.leftView = self.cityButton
        self.leftView?.addBorderRight(color:Color.white,padding: 7)
        self.leftViewMode = .always
        
        self.rightView = self.searchIconView
        self.rightView?.width = defaultHeight * 1.5
        self.rightViewMode = .always
    }
}
