

import UIKit

extension UIColor {
    /// ZJaDe: init method with RGB values from 0 to 255, instead of 0 to 1. With alpha(default:1)
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    /// ZJaDe: init method with hex string and alpha(default: 1)
    convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
          let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
          let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
          let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
          self.init(red: red, green: green, blue: blue, alpha: alpha)        } else {
            return nil
        }
    }

    /// ZJaDe: init method from Gray value and alpha(default:1)
    convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(red: gray/255, green: gray/255, blue: gray/255, alpha: alpha)
    }

    /// ZJaDe: Red component of UIColor (get-only)
    var redComponent: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }

    /// ZJaDe: Green component of UIColor (get-only)
    var greenComponent: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }

    /// ZJaDe: blue component of UIColor (get-only)
    var blueComponent: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }

    /// ZJaDe: Alpha of UIColor (get-only)
    var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
    func alpha(_ alpha:CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }

    /// ZJaDe: Returns random UIColor with random alpha(default: false)
    static func randomColor(_ randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }

}
extension UIColor {
    static func animateScaleColor(beginColor:UIColor,endColor:UIColor,percentComplete:CGFloat) -> UIColor {
        var red1:CGFloat=0,green1:CGFloat=0,blue1:CGFloat=0,alpha1:CGFloat=0
        var red2:CGFloat=0,green2:CGFloat=0,blue2:CGFloat=0,alpha2:CGFloat=0
        
        beginColor.getRed(&red1, green: &green1, blue: &blue1, alpha: &alpha1)
        endColor.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        red1 += percentComplete * (red2 - red1)
        green1 += percentComplete * (green2 - green1)
        blue1 += percentComplete * (blue2 - blue1)
        alpha1 += percentComplete * (alpha2 - alpha1)
        
        return UIColor(red: red1, green: green1, blue: blue1, alpha: alpha1)
    }
}
