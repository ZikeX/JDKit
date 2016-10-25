//
//  PriceCellProtocol.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol PriceCellProtocol {
    weak var priceLabel:UILabel! {get set}
    func setPriceLabelText(price:CGFloat,suffix:String?,suffixFont:UIFont?)
}
extension PriceCellProtocol {
    func setPriceLabelText(price:CGFloat,suffix:String? = nil,suffixFont:UIFont? = nil) {
        let attriStr = NSMutableAttributedString()
        attriStr.append(NSAttributedString(string: "￥\(price)", attributes: [NSForegroundColorAttributeName:Color.orange]))
        if suffix != nil {
            if suffixFont != nil {
                attriStr.append(NSAttributedString(string: suffix!, attributes: [NSForegroundColorAttributeName:Color.gray,NSFontAttributeName:suffixFont!]))
            }else {
                attriStr.append(NSAttributedString(string: suffix!, attributes: [NSForegroundColorAttributeName:Color.gray]))
            }
        }
        priceLabel.attributedText = attriStr
    }
}
