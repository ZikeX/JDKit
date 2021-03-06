//
//  TableSection.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/19.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class TableSection:ListSection {
    var headerViewHeight:CGFloat = 0.1
    var footerViewHeight:CGFloat = 0.1
    
    var headerViewColor:UIColor?
    var footerViewColor:UIColor?
    
    var headerView:UITableViewHeaderFooterView = UITableViewHeaderFooterView()
    var footerView:UITableViewHeaderFooterView = UITableViewHeaderFooterView()
    
    func setHeaderTitle(_ title:String,font:UIFont = Font.h4,color:UIColor = Color.lightGray) {
        self.headerView.thenMain { (headerView) in
            headerView.textLabel?.text = title
            headerView.textLabel?.font = font
            headerView.textLabel?.textColor = color
        }
    }
}
