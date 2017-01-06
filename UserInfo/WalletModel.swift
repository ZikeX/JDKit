//
//  WalletModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/30.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class WalletModel: BaseEntityModel {
    var balance:PriceValue?
    var hasPaypwd:Bool = false
    var idcardAuditState:String = ""
    
    var bankAmount:Int = 0
    var hasBank:Bool {
        return self.bankAmount > 0
    }
    
    var hasAlipay:Bool = false
    
    var incomeAmount:String = ""
    var expendAmount:String = ""
}
