
import UIKit

/// ZJaDe: 两个属性字符串拼接
func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}
func += (left: inout NSMutableAttributedString, right: NSAttributedString) {
    left.append(right)
}

func += (left: inout AttrStrContainer, right: AttrStrContainer) {
    left.attrStr.append(right.attrStr)
}

class AttrStrContainer {
    var attrStr:NSMutableAttributedString
    
    init(_ str: String) {
        self.attrStr = NSMutableAttributedString(string: str)
    }
    
    func font(_ font:UIFont, range:NSRange? = nil) -> Self {
        let range = range ?? (self.attrStr.string as NSString).range(of: self.attrStr.string)
        self.attrStr.addAttribute(NSFontAttributeName, value: font, range: range)
        return self
    }
    
    func color(_ color:UIColor, range:NSRange? = nil) -> Self {
        let range = range ?? (self.attrStr.string as NSString).range(of: self.attrStr.string)
        self.attrStr.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        return self
    }
}
