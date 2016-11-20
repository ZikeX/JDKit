//
//  DatePicker.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class DatePicker: CustomIBControl {
    let dateObservable = PublishSubject<(Date)>()
    
    lazy var titleLabel:UILabel = {
        let label = UILabel(color: Color.black, font: Font.h1)
        label.textAlignment = .center
        return label
    }()
    lazy var cancelLabel:Button = {
        let button = Button(title: "取消")
        button.textLabel.font = Font.h1
        button.addBorderRight(padding:5)
        _ = button.rx.tap.subscribe(onNext: {[unowned self] (event) in
            self.hide()
        })
        return button
    }()
    lazy var makeSureLabel:Button = {
        let button = Button(title: "确定")
        button.textLabel.font = Font.h1
        _ = button.rx.tap.subscribe(onNext: {[unowned self] (event) in
            self.dateObservable.onNext(self.datePicker.date)
            self.hide()
        })
        return button
    }()
    lazy var datePicker:UIDatePicker = UIDatePicker()
    
    override func configInit() {
        super.configInit()
        self.cornerRadius = 5
        self.backgroundColor = Color.white
        self.datePicker.backgroundColor = Color.lightViewBackground
        self.datePicker.tintColor = Color.tintColor
        self.configLayout()
    }
}
extension DatePicker {
    func configLayout() {
        let bottomStackView = UIStackView(arrangedSubviews: [self.cancelLabel,self.makeSureLabel])
        bottomStackView.distribution = .fillEqually
        bottomStackView.heightValue(height: 64)
        
        titleLabel.heightValue(height: 64)
        
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel,self.datePicker,bottomStackView])
        stackView.axis = .vertical
        self.addSubview(stackView)
        stackView.edgesToView()
    }
}
extension DatePicker {
    func show(title:String) {
        self.titleLabel.text = title
        let contentView = WindowBackgroundView()
        contentView.addSubview(self)
        
        contentView.showClosure = {[unowned self] in
            self.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
            })
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
        contentView.hideClosure = {[unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        }
        contentView.show()
    }
    func hide() {
        let contentView = self.superview as? WindowBackgroundView
        contentView?.hide()
    }
}
