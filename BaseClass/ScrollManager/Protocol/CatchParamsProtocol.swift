//
//  CatchParamsProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

protocol CatchParamsProtocol {
    var key:String {get}
    func catchParms() -> [String:Any]
}
