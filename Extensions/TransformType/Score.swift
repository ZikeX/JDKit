//
//  Score.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/17.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
typealias ScoreValue = Double
extension ScoreValue {
    func scoreFormatStr(_ formatter:NumberFormatter) -> String {
        let number = NSNumber(value: self)
        let valueStr = formatter.string(from: number) ?? "分数出错"
        return "\(valueStr)"
    }
}

struct Score {
    typealias NativeType = ScoreValue
    fileprivate var _value:NativeType
    var formatter:NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingIncrement = NSNumber(value: 0.1)
        return formatter
    }()
    
    var value:NativeType {
        get {
            return self._value.roundToNearest(increment: self.formatter.roundingIncrement.doubleValue)
        }
        set {
            self._value = newValue
        }
    }
}
extension Score {
    init(_ double:Double) {
        self._value = double
    }
    init(_ float:Float) {
        self._value = float.toDouble
    }
}
extension Score:ExpressibleByFloatLiteral {
    init(floatLiteral value: FloatLiteralType) {
        self._value = value
    }
}
extension Score:ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self._value = value.toDouble
    }
}
extension Score:CustomStringConvertible {
    var description: String {
        return "\(_value.scoreFormatStr(formatter))"
    }
}
