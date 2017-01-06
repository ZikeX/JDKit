//
//  Price.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/17.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

extension Double {
    var yuan:Price {
        return Price(self)
    }
}

typealias PriceValue = Double

struct Price {
    typealias NativeType = PriceValue
    
    var value:NativeType?
    var toValueStr:String {
        if let value = self.value {
            return String(format: "%.2f", value)
        }else {
            return "??"
        }
    }
    var currencySymbol:String {
        return PriceFormatter().currencySymbol
    }
}
extension Price {
    init(_ double:Double?) {
        self.value = double
    }
    init(_ float:Float?) {
        self.value = float?.toDouble
    }
}
extension Price:ExpressibleByFloatLiteral {
    init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }
}
extension Price:ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self.value = value.toDouble
    }
}
extension Price:CustomStringConvertible {
    var description: String {
        return "\(PriceFormatter().string(from: self))"
    }
}
