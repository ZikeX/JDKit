//
//  JDListSection.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDListSection: NSObject {
    var identity: Int {
        return self.hashValue
    }
}
extension JDListSection: IdentifiableType {
    
}
