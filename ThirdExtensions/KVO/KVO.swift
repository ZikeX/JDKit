////
////  KVOController.swift
////  ZiWoYou
////
////  Created by 茶古电子商务 on 16/11/19.
////  Copyright © 2016年 Z_JaDe. All rights reserved.
////
//
//import Foundation
//import RxSwift
//
//protocol KVOCompatible {
//    associatedtype CompatibleType:NSObject
//    var rx:Reactive<CompatibleType> {get}
//    func kvo<E:Equatable>(_type:E.Type,keyPath:String,closure:@escaping (CompatibleType,E?)->()) -> Disposable
//    func kvo<E>(_type:E.Type,keyPath:String,comparer:@escaping (E?, E?) -> Bool,closure:@escaping (CompatibleType,E?)->()) -> Disposable
//    
//    func weakKvo<E:Equatable>(_type:E.Type,keyPath:String,closure:@escaping (CompatibleType,E?)->()) -> Disposable
//    func weakKvo<E>(_type:E.Type,keyPath:String,comparer:@escaping (E?, E?) -> Bool,closure:@escaping (CompatibleType,E?)->()) -> Disposable
//}
//extension KVOCompatible where Self:NSObject {
//    func kvo<E:Equatable>(_type:E.Type,keyPath:String,closure:@escaping (Self,E?)->()) -> Disposable {
//        return self.kvo(_type: E.self, keyPath: keyPath, comparer: {$0==$1}, closure: closure)
//    }
//    func kvo<E>(_type:E.Type,keyPath:String,comparer:@escaping (E?, E?) -> Bool,closure:@escaping (Self,E?)->()) -> Disposable {
//        let disposeBag = self.rx.observe(E.self, keyPath).distinctUntilChanged(comparer).subscribe {[unowned self] (event) in
//            if let e = event.element {
//                closure(self,e)
//            }
//        }
//        return disposeBag
//    }
//    
//    func weakKvo<E:Equatable>(_type:E.Type,keyPath:String,closure:@escaping (Self,E?)->()) -> Disposable {
//        return self.weakKvo(_type: E.self, keyPath: keyPath, comparer: {$0==$1}, closure: closure)
//    }
//    func weakKvo<E>(_type:E.Type,keyPath:String,comparer:@escaping (E?, E?) -> Bool,closure:@escaping (Self,E?)->()) -> Disposable {
//        let disposeBag = self.rx.observeWeakly(E.self, keyPath).debug().distinctUntilChanged(comparer).subscribe {[unowned self] (event) in
//            if let e = event.element {
//                closure(self,e)
//            }
//        }
//        return disposeBag
//    }
//}
//extension NSObject: KVOCompatible {
//}
