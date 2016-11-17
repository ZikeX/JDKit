//
//  Fonts.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class Font {
    static var big1 = UIFont(name:"PingFang SC", size: 22.5)!
    
    static var h1 = UIFont(name:"PingFang SC", size: 18)!
    static var h2 = UIFont(name:"PingFang SC", size: 16)!
    static var h3 = UIFont(name:"PingFang SC", size: 14.5)!
    static var h4 = UIFont(name:"PingFang SC", size: 13.5)!
    static var h5 = UIFont(name:"PingFang SC", size: 12)!
    
    static func size(size:CGFloat) -> UIFont {
        return UIFont(name:"PingFang SC", size: size)!
    }
    static func num(num:Int) -> UIFont {
        switch num {
        case 1:
            return Font.h1
        case 2:
            return Font.h2
        case 3:
            return Font.h3
        case 4:
            return Font.h4
        case 5:
            return Font.h5
        default:
            return Font.h1
        }
    }
}
