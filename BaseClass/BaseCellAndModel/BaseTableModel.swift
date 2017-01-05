//
//  JDBaseTableModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import HandyJSON

class BaseTableModel: TableModel,HandyJSON {
    var id:Int? = nil
    
    override func configModelInit() {
        super.configModelInit()
        isNibCell = true
        self.spaceEdges = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func mapping(mapper: HelpingMapper) {
        
    }
}
extension Variable:Property {}
extension UIEdgeInsets:Property {}
extension CGFloat:Property {}
extension UIColor:Property {}
extension UIView:Property {}
