//
//  JDGenderCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDGenderCell: JDFormCell {
    var boyButton = Button(title: "男", image: R.image.ic_gender_未选())
    var girlButton = Button(title: "女", image: R.image.ic_gender_未选())
    var currentGenderStr:String? {
        willSet {
            if currentGenderStr == "男" {
                boyButton.img = R.image.ic_gender_未选()
            }else if currentGenderStr == "女" {
                girlButton.img = R.image.ic_gender_未选()
            }
        }
        didSet {
            if currentGenderStr == "男" {
                self.boyButton.img = R.image.ic_gender_男()
            }else if currentGenderStr == "女" {
                self.girlButton.img = R.image.ic_gender_女()
            }
        }
    }
    
    fileprivate let genderStackView = UIStackView(alignment: .center, distribution: .equalCentering, spacing: 120)
    
    override func configItemInit() {
        super.configItemInit()
        
        stackView.snp.makeConstraints { (maker) in
            maker.centerY.equalToSuperview()
        }
        
        [boyButton,girlButton].forEach { (button) in
            button.titleAndImgLocation = .rightToLeft
            button.itemSpace = 10
            button.textLabel.font = Font.h3
            button.textLabel.textColor = Color.black
        }
        
        self.jdContentView.addSubview(genderStackView)
        
        genderStackView.addArrangedSubview(boyButton)
        genderStackView.addArrangedSubview(girlButton)
        genderStackView.snp.makeConstraints { (maker) in
            maker.centerY.top.equalToSuperview()
            maker.leftSpace(stackView).offset(0)
        }
    }
}
extension JDGenderCell {
    override func configItem(_ model: JDTableModel) {
        super.configItem(model)
        guard let model = model as? JDGenderModel else {
            return
        }
        genderStackView.snp.updateConstraints({ (maker) in
            maker.leftSpace(stackView).offset(model.titleRightSpace)
        })
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDGenderModel else {
            return
        }
        model.gender.asObservable().subscribe(onNext:{[unowned self] (gender) in
            self.currentGenderStr = gender
        }).addDisposableTo(disposeBag)
        
        boyButton.rx.touchUpInside { (button) in
            model.gender.value = "男"
        }.addDisposableTo(disposeBag)
        girlButton.rx.touchUpInside { (button) in
            model.gender.value = "女"
        }.addDisposableTo(disposeBag)
    }
}
