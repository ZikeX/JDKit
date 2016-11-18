//
//  Score.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/17.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
typealias ScoreValue = Double

struct Score {
    typealias NativeType = ScoreValue
    var formatter:ScoreFormatter = {
        return ScoreFormatter(0.1)
    }()
    
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
        return "\(formatter.string(from: self))"
    }
}
