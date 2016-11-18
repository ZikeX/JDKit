//
//  Price.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/17.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
typealias PriceValue = Double
extension PriceValue {
    func priceFormatStr(_ formatter:NumberFormatter) -> String {
        let number = NSNumber(value: self)
        let valueStr = formatter.string(from: number) ?? "金额出错"
        return "\(valueStr)"
    }
}
struct Price {
    typealias NativeType = PriceValue
    fileprivate var _value:NativeType
    var formatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        return formatter
    }()
    
    var value:NativeType {
        get {
            return self._value.roundToNearest(increment: 0.01)
        }
        set {
            self._value = newValue
        }
    }
    var toValueStr:String {
        return String(format: "%.2f", _value)
    }
    var currencySymbol:String {
        return formatter.currencySymbol
    }
}
extension Price:ExpressibleByFloatLiteral {
    init(floatLiteral value: FloatLiteralType) {
        self._value = value
    }
}
extension Price:ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self._value = value.toDouble
    }
}
extension Price:CustomStringConvertible {
    var description: String {
        return "\(_value.priceFormatStr(formatter))"
    }
}
