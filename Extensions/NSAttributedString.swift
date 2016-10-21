
import UIKit

extension NSAttributedString {
    var mutableStr:NSMutableAttributedString? {
        return self.mutableCopy() as? NSMutableAttributedString
    }
    
    /// ZJaDe: 属性字符串添加颜色属性
    func color(_ color: UIColor) -> NSAttributedString {
        guard let copy = mutableStr else { return self }

        let range = (self.string as NSString).range(of: self.string)
        copy.addAttributes([NSForegroundColorAttributeName: color], range: range)
        return copy
    }
}

/// ZJaDe: 两个属性字符串拼接
func += (left: inout NSAttributedString, right: NSAttributedString) {
    let ns = NSMutableAttributedString(attributedString: left)
    ns.append(right)
    left = ns
}
