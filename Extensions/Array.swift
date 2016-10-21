//
//  Array.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

extension Array {
    mutating func countIsEqual(_ count:Int, _ appendMethod:()-> Element) {
        while self.count != count {
            if self.count > count {
                removeLast()
            }else {
                append(appendMethod())
            }
        }
    }
}
