//
//  TransitionProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol TransitionProtocol {
    var transitionVC:TransitionViewController {get set}
    func configTransition(segmentedControl:SegmentedControl?,closure:((Int)->BaseTableViewController)?)
    func updateTransition(segmentedControl:SegmentedControl?,closure:((Int)->BaseTableViewController))
}
extension TransitionProtocol where Self:BaseViewController {
    func configTransition(segmentedControl:SegmentedControl?,closure:((Int)->BaseTableViewController)? = nil) {
        _ = segmentedControl?.rx.value.asObservable().subscribe { (event) in
            if let index = event.element,index < self.transitionVC.listArray.count {
                self.transitionVC.selectedIndex = index
            }
        }
        if closure != nil {
            updateTransition(segmentedControl: segmentedControl, closure: closure!)
        }
    }
    func updateTransition(segmentedControl:SegmentedControl?,closure:((Int)->BaseTableViewController)) {
        self.transitionVC.listArray = {
            var array = [ScrollProperty]()
            for index in 0..<(segmentedControl?.modelArray.count ?? 1) {
                array.append(closure(index))
            }
            return array
        }()
    }
}
