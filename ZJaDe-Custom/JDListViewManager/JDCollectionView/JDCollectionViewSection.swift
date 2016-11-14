//
//  JDCollectionViewSection.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/25.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDCollectionViewSection:NSObject {
    var identity: Int {
        return self.hashValue
    }
}
extension JDCollectionViewSection: IdentifiableType {
    
}
