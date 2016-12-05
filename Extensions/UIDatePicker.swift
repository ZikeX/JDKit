//
//  DatePicker.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
private var DateChangeObserKey:Int8 = 0
extension UIDatePicker {
    var dateObservable:PublishSubject<(Date)> {
        get {
            var _dateObservable:PublishSubject<Date>
            if let existing = objc_getAssociatedObject(self, &DateChangeObserKey) as? PublishSubject<Date> {
                _dateObservable = existing
            }else {
                _dateObservable = PublishSubject<(Date)>()
                self.dateObservable = _dateObservable
            }
            return _dateObservable
        }
        set {
            objc_setAssociatedObject(self, &DateChangeObserKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func show(title:String) {
        Alert().configClick { (index) in
            self.dateObservable.onNext(self.date)
            self.hide()
        }.configShowLayout { (alert, contentView) in
            self.backgroundColor = Color.lightViewBackground
            self.tintColor = Color.tintColor
            alert.titleButton.textStr = title
            contentView.addSubview(self)
            self.edgesToView()
        }.show()
    }
    func hide() {
        Alert.hide()
    }
}
