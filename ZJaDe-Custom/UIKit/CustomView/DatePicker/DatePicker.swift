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
    lazy var datePicker:UIDatePicker = UIDatePicker()
    
    override func configInit() {
        super.configInit()
        self.datePicker.backgroundColor = Color.lightViewBackground
        self.datePicker.tintColor = Color.tintColor
    }
}
extension DatePicker {
    func show(title:String) {
        Alert().configClick { (index) in
            self.dateObservable.onNext(self.datePicker.date)
            self.hide()
        }.configShowLayout { (alert, contentView) in
            alert.titleLabel.text = title
            contentView.addSubview(self)
            self.edgesToView()
        }.show()
    }
    func hide() {
        Alert.hide()
    }
}
