//
//  UIView+Frame.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/7.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension UIView {
    var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
    }
    var bottom:CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
    }
    var right:CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
    }
    var centerY:CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    var centerX:CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center.x = newValue
        }
    }
    var width:CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
    var height:CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set(value) {
            self.frame.origin.x = value
        }
    }
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set(value) {
            self.frame.origin.y = value
        }
    }
    var origin: CGPoint {
        get {
            return self.frame.origin
        } set(value) {
            self.frame.origin = value
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        } set(value) {
            self.frame.size = value
        }
    }
}
