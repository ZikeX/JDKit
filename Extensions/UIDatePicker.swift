//
//  DatePicker.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
private var dateChangeObserKey:UInt8 = 0
extension UIDatePicker {
    var dateObservable:PublishSubject<(Date)> {
        get {
            return associatedObject(&dateChangeObserKey, createIfNeed: {PublishSubject<(Date)>()})
        }
        set {
            setAssociatedObject(&dateChangeObserKey, newValue)
        }
    }
    var isShowing:Bool {
        return self.superview != nil
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
