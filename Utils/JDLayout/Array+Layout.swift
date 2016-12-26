//
//  Array+Layout.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension Array where Element:UIView {
    func layoutItems(_ closure:(Element?,Element,Int)->()) {
        var preItem:Element?
        for (index,item) in self.enumerated() {
            closure(preItem,item,index)
            preItem = item
        }
    }
}
