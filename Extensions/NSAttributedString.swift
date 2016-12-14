
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
    lazy var defaultRange:NSRange = {
        NSMakeRange(0, self.attrStr.length)
    }()
    init(_ str: String) {
        self.attrStr = NSMutableAttributedString(string: str)
    }
    init(_ attrStr: NSAttributedString? = nil) {
        if attrStr == nil {
            self.attrStr = NSMutableAttributedString()
        }else {
            self.attrStr = NSMutableAttributedString(attributedString: attrStr!)
        }
    }
    
    func font(_ font:UIFont, range:NSRange? = nil) -> Self {
        let range = range ?? defaultRange
        self.attrStr.addAttribute(NSFontAttributeName, value: font, range: range)
        return self
    }
    
    func color(_ color:UIColor, range:NSRange? = nil) -> Self {
        let range = range ?? defaultRange
        self.attrStr.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        return self
    }
    func underLine(_ color:UIColor = Color.gray, range:NSRange? = nil) -> Self {
        let range = range ?? defaultRange
        let underLineStyle:NSUnderlineStyle = .styleSingle
        self.attrStr.addAttributes([NSStrikethroughStyleAttributeName:NSNumber(value: underLineStyle.rawValue),NSStrikethroughColorAttributeName:color], range: range)
        return self
    }
    func lineSpacing(_ spacing:CGFloat, range:NSRange? = nil) -> Self {
        let range = range ?? defaultRange
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byTruncatingTail
        style.lineSpacing = spacing
        self.attrStr.addAttributes([NSParagraphStyleAttributeName:style], range: range)
        return self
    }
}
