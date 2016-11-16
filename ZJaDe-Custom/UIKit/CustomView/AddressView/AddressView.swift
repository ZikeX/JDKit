//
//  AddressView.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/16.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class AddressView: CustomIBView {

    var addressLabel = UILabel(text: "定位位置未知", color: Color.black, font: Font.h4)
    var locationImgView:ImageView = {
        let imageView = ImageView(image: R.image.ic_location()?.templateImage)
        imageView.tintColor = Color.black
        return imageView
    }()
    var goThereButton:Button = {
        let button = Button(title: "去这里")
        button.tintColor = Color.tintColor
        button.textLabel.font = Font.h3
        return button
    }()
    
    override func configInit() {
        super.configInit()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configLayout()
    }
    func configLayout() {
        let mainStackView = UIStackView(alignment: .center, distribution: .equalCentering, spacing: 0)
        mainStackView.addArrangedSubview(locationImgView)
        mainStackView.addArrangedSubview(addressLabel)
        mainStackView.addArrangedSubview(goThereButton)
        addressLabel.snp.makeConstraints { (maker) in
            maker.leftSpace(locationImgView).offset(5)
        }
        goThereButton.snp.makeConstraints { (maker) in
            maker.leftSpace(addressLabel).offset(30)
        }
        locationImgView.contentPriority(UILayoutPriorityRequired)
        goThereButton.contentPriority(UILayoutPriorityRequired)
        
        self.addSubview(mainStackView)
        mainStackView.edgesToView()
    }
}
