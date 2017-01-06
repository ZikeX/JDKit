//
//  PaypwdAlert.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/6.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit

class PaypwdAlert: BaseAlert {
    var alertTitle:String = "" {
        didSet {
            self.titleLabel.text = alertTitle
        }
    }
    var alertDetailTitle:String = "" {
        didSet {
            self.detailTitleLabel.text = alertDetailTitle
        }
    }
    var price:PriceValue = 0 {
        didSet {
            self.updatePrice()
        }
    }
    func configCallback(_ closure:@escaping (String)->()) -> Self {
        self.callback = closure
        return self
    }
    // MARK: -
    lazy private var titleLabel:UILabel = UILabel(color: Color.black, font: Font.h4)
    lazy private var priceLabel:UILabel = UILabel(color: Color.tintColor, font: Font.h3)
    lazy private var detailTitleLabel:UILabel = UILabel(color: Color.black, font: Font.h3)
    lazy private(set) var payPasswordView:PayPasswordView = PayPasswordView()
    private var callback:((String)->())?
    
    func updatePrice() {
        var container = AttrStrContainer("\(Price(self.price))").font(Font.p40)
        container += AttrStrContainer("元").font(Font.h3)
        priceLabel.attributedText = container.attrStr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.payPasswordView.configPaypwdInputCallback {[unowned self] (paypwd) in
            self.callback?(paypwd)
        }
    }
    override func configBaseLayout() {
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        let contentView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 0)
        self.baseView.addSubview(contentView)
        contentView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        }
        contentView.addArrangedSubview(UIStackView().then({ (stackView) in
            stackView.alignment = .center
            stackView.spacing = 10
            stackView.heightValue(height: 44)
            stackView.addBorderBottom()
            
            let cancelButton = Button(image: R.image.ic_cancel(),isTemplate:true)
            cancelButton.tintColor = Color.gray
            cancelButton.rx.touchUpInside({[unowned self] (button) in
                self.hide()
            })
            let label = UILabel(text: "请输入安全密码", color: Color.black, font: Font.h4)
            stackView.addArrangedSubview(cancelButton)
            cancelButton.contentPriority(UILayoutPriorityRequired)
            stackView.addArrangedSubview(label)
        }))
        contentView.addArrangedSubview(UIView().then({ (mainView) in
            mainView.addBorderBottom()
            
            mainView.addSubview(self.titleLabel)
            mainView.addSubview(self.priceLabel)
            self.titleLabel.snp.makeConstraints({ (maker) in
                maker.top.equalToSuperview().offset(40)
                maker.centerX.equalToSuperview()
            })
            self.priceLabel.snp.makeConstraints({ (maker) in
                maker.topSpace(self.titleLabel).offset(20)
                maker.bottom.equalToSuperview().offset(-40)
                maker.centerX.equalToSuperview()
            })
        }))
        contentView.addArrangedSubview(self.detailTitleLabel.then({ (label) in
            label.heightValue(height: 44)
            label.addBorderBottom()
        }))
        contentView.addArrangedSubview(UIView().then({ (mainView) in
            mainView.addSubview(self.payPasswordView)
            self.payPasswordView.snp.makeConstraints({ (maker) in
                maker.top.equalToSuperview().offset(10)
                maker.left.centerX.bottom.equalToSuperview()
            })
        }))
    }
}
