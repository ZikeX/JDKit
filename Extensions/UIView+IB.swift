//
//  UIView+IB.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/7.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

@IBDesignable class IBView: UIView {
    
}
@IBDesignable class IBButton: UIButton {
    
}
@IBDesignable class IBImageView: UIImageView {
    
}
extension UIButton {
    @IBInspectable override var hasShadow:Bool {
        get {
            return self.layer.shadowOpacity > 0
        }
        set {
            if newValue {
                self.addButtonShadow()
            }else {
                self.layer.shadowOpacity = 0
            }
        }
    }
}
extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            //self.clipsToBounds = newValue > 0
        }
    }
    @IBInspectable var boderColor:UIColor {
        get {
            return Color.boderLine
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    @IBInspectable var boderWidth:CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    @IBInspectable var hasShadow:Bool {
        get {
            return self.layer.shadowOpacity > 0
        }
        set {
            if newValue {
                self.addShadowInWhiteView()
            }else {
                self.layer.shadowOpacity = 0
            }
        }
    }
}
