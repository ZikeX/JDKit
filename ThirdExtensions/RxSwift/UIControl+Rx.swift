//
//  UIControl+Rx.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base:UIControl {
    @discardableResult
    func controlEvent(_ controlEvents: UIControlEvents,_ closure:((Base)->())?) -> Disposable {
        return self.controlEvent(controlEvents).subscribe(onNext:{[unowned base] () in
            closure?(base)
        })
    }
    @discardableResult
    func touchUpInside(_ closure:((Base)->())?) -> Disposable {
        return self.controlEvent(.touchUpInside, closure)
    }
    @discardableResult
    func valueChanged(_ closure:((Base)->())?) -> Disposable {
        return self.controlEvent(.valueChanged, closure)
    }
}
extension Reactive where Base: UIControl {
    static func valuePublic<T, ControlType: UIControl>(control: ControlType, getter:@escaping (ControlType) -> T, setter: @escaping (ControlType, T) -> ()) -> ControlProperty<T> {
        let values: Observable<T> = Observable.deferred { [weak control] in
            guard let existingSelf = control else {
                return Observable.empty()
            }
            return (existingSelf as UIControl).rx.controlEvent([.allEditingEvents, .valueChanged])
                .flatMap { _ in
                    return control.map { Observable.just(getter($0)) } ?? Observable.empty()
                }
                .startWith(getter(existingSelf))
        }
        return ControlProperty(values: values, valueSink: UIBindingObserver(UIElement: control) { control, value in
            setter(control, value)
        })
    }
}
