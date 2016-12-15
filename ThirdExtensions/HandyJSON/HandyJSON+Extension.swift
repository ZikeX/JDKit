//
//  HandyJSON+Extension.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import HandyJSON

extension HandyJSON {
    func toSimpleDictionary() -> [String:Any] {
        return JSONSerializer.serialize(model: self).toSimpleDictionary() ?? [String:Any]()
    }
}
