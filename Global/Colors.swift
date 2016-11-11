//
//  Colors.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class Color {
    
    static var clear = Color.colorFromRGB("#00ffffff")!
    static var red = Color.colorFromRGB("#f16568")!
    static var blue = Color.colorFromRGB("#009bfe")!
    static var green = Color.colorFromRGB("#54b022")!
    static var white = Color.colorFromRGB("#ffffff")!
    static var black = Color.colorFromRGB("#474747")!
    static var darkBlack = Color.colorFromRGB("#000000")!
    static var darkGray = Color.colorFromRGB("#838383")!
    static var gray = Color.colorFromRGB("#8c8c8c")!
    static var lightGray = Color.colorFromRGB("#cccccc")!
    
    static var orange = Color.colorFromRGB("#ff822e")!
    static var eggYellow = Color.colorFromRGB("#ffd05f")!
    
    static var tintColor = Color.green
    static var selectedCell = Color.colorFromRGB("#fffff0")!
    static var viewBackground = Color.colorFromRGB("#f3f3f3")!
    static var lightViewBackground = Color.colorFromRGB("#f9f9f9")!
    static var separatorLine = Color.viewBackground
    static var boderLine = Color.colorFromRGB("#ececec")!
    static var shadow = Color.colorFromRGB("#000000")!
    static var placeholder = Color.colorFromRGB("#c7c7cd")!
    
    
    class func colorFromRGB(_ hexString:String) -> UIColor? {
        var red:CGFloat
        var blue:CGFloat
        var green:CGFloat
        var alpha:CGFloat
        let colorString = hexString.replacingOccurrences(of: "#", with:"")
        switch colorString.characters.count {
        case 3://#RGB
            alpha = 1.0;
            red   = colorComponentFrom(colorString, 0, 1);
            green = colorComponentFrom(colorString, 1, 1);
            blue  = colorComponentFrom(colorString, 2, 1);
        case 4://#ARGB
            alpha = colorComponentFrom(colorString, 0, 1);
            red   = colorComponentFrom(colorString, 1, 1);
            green = colorComponentFrom(colorString, 2, 1);
            blue  = colorComponentFrom(colorString, 3, 1);
        case 6://#RRGGBB
            alpha = 1.0;
            red   = colorComponentFrom(colorString, 0, 2);
            green = colorComponentFrom(colorString, 2, 2);
            blue  = colorComponentFrom(colorString, 4, 2);
        case 8://#AARRGGBB
            alpha = colorComponentFrom(colorString, 0, 2);
            red   = colorComponentFrom(colorString, 2, 2);
            green = colorComponentFrom(colorString, 4, 2);
            blue  = colorComponentFrom(colorString, 6, 2);
        default:
            return nil
        }
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    class func colorComponentFrom(_ string:String,_ start:Int,_ length:Int) -> CGFloat {
        let subString = string.substring(with: Range(string.characters.index(string.startIndex, offsetBy: start) ..< string.characters.index(string.startIndex, offsetBy: start+length)))
        let fullHex = length == 2 ? subString : subString+subString;
        var hexComponent:UInt32 = 0
        if let screen = Scanner.localizedScanner(with: fullHex) as? Scanner {
            screen.scanHexInt32(&hexComponent)
        }
        return CGFloat(hexComponent) / 255.0
    }
}

