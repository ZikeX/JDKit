//
//  JDTableViewSection.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/19.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDTableViewSection:NSObject {
    var headerViewHeight:CGFloat = 0.1
    var footerViewHeight:CGFloat = 0.1
    
    var headerView:UIView? = UIView()
    var footerView:UIView? = UIView()
    
    var identity: Int {
        return self.hashValue
    }
}
extension JDTableViewSection:IdentifiableType {
    
}
