//
//  TransformType.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/17.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

protocol TransformTypeProtocol {
    var toString:String {get}
}
extension TransformTypeProtocol {
    var toString:String {
        return "\(self)"
    }
}

extension Price:TransformTypeProtocol {
}
extension Score:TransformTypeProtocol {
    var toCGFloat:CGFloat {
        return CGFloat(self.value)
    }
    var toInt:Int {
        return Int(self.value)
    }
}

extension Double:TransformTypeProtocol {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toFloat: Float { return Float(self) }
    var toDouble: Double { return Double(self) }
    var toInt: Int { return Int(self) }
}
extension Float:TransformTypeProtocol {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toFloat: Float { return Float(self) }
    var toDouble: Double { return Double(self) }
    var toInt: Int { return Int(self) }
}
extension CGFloat:TransformTypeProtocol {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toFloat: Float { return Float(self) }
    var toDouble: Double { return Double(self) }
    var toInt: Int { return Int(self) }
}
extension Int:TransformTypeProtocol {
    var toCGFloat: CGFloat { return CGFloat(self) }
    var toFloat: Float { return Float(self) }
    var toDouble: Double { return Double(self) }
    var toInt: Int { return Int(self) }
    var toUInt: UInt { return UInt(self) }
}
extension UInt:TransformTypeProtocol {
    var toInt: Int { return Int(self) }
}
extension String:TransformTypeProtocol {
    var toNSString: NSString {
        return self as NSString
    }
    var toInt:Int? {
        return NumberFormatter().number(from: self)?.intValue
    }
    var toDouble:Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    var toFloat:Float? {
        return NumberFormatter().number(from: self)?.floatValue
    }
    var toBool:Bool? {
        let trimmed = self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).lowercased()
        switch trimmed {
        case "true","1","yes":
            return true
        case "false","0","no":
            return false
        default:
            return nil
        }
    }
}
