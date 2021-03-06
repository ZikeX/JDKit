//
//  Score.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/17.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

extension Double {
    var fen:Score {
        return Score(self)
    }
}

typealias ScoreValue = Double

struct Score {
    typealias NativeType = ScoreValue
    
    var value:NativeType
    
    var toValueStr:String {
        return String(format: "%.1f", value)
    }
}
extension Score {
    init(_ double:Double) {
        self.value = double
    }
    init(_ float:Float) {
        self.value = float.toDouble
    }
}
extension Score:ExpressibleByFloatLiteral {
    init(floatLiteral value: FloatLiteralType) {
        self.value = value
    }
}
extension Score:ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self.value = value.toDouble
    }
}
extension Score:CustomStringConvertible {
    var description: String {
        return "\(ScoreFormatter().string(from: self))"
    }
}
