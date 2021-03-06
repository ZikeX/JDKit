//
//  JDStaticCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDStaticCell: TableCell {
    var jdFocusView:UIView?
    
    override func configItemInit() {
        super.configItemInit()
        appearAnimatedStyle = .fromInsideOut
        highlightAnimatedStyle = .none
    }
    
    override func bindingModel(_ model: TableModel) {
        self.configCell()
    }
    
}
extension JDStaticCell {
    func configCell() {
        
    }
}
extension JDStaticCell {//cell第一响应者 焦点View
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.jdFocusView?.becomeFirstResponder()
        }
    }
}
