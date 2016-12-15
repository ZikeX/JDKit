
import UIKit
private var jd_panKey: UInt8 = 0
private var jd_tapKey: UInt8 = 0
extension UIView {
    func getPan() -> UIPanGestureRecognizer {
        return associatedObject(&jd_panKey, createIfNeed: { () -> UIPanGestureRecognizer in
            let pan = UIPanGestureRecognizer()
            self.addGestureRecognizer(pan)
            return pan
        })
    }
    func getTap() -> UITapGestureRecognizer {
        return associatedObject(&jd_tapKey, createIfNeed: { () -> UITapGestureRecognizer in
            let tap = UITapGestureRecognizer()
            self.addGestureRecognizer(tap)
            return tap
        })
    }
}
extension UIView {
    func addShadowInWhiteView(scale:CGFloat = 1) {
        self.layer.shadowColor = Color.shadow.cgColor
        self.layer.shadowOpacity = 0.25 * scale.toFloat
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
    }
    func addShadow(offset: CGSize = CGSize(width: 0, height: 1), color:UIColor = Color.shadow,opacity:Float = 0.15,radius:CGFloat = 2.5) {
        if self.backgroundColor == nil {
            self.backgroundColor = Color.white
        }
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
    }
    func addButtonShadow() {
        self.addShadow(radius:1.5)
    }
}

extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            if let stackView = self as? UIStackView {
                stackView.removeArrangedSubview(subview)
            }
            subview.removeFromSuperview()
        }
    }
    func centerXInSuperView() {
        guard let parentView = superview else {
            assertionFailure("ZJade Error: \(self) 没有superview")
            return
        }
        
        self.x = parentView.width/2 - self.width/2
    }
    func centerYInSuperView() {
        guard let parentView = superview else {
            assertionFailure("ZJade Error: \(self) 没有superview")
            return
        }
        
        self.y = parentView.height/2 - self.height/2
    }
    func centerInSuperView() {
        self.centerXInSuperView()
        self.centerYInSuperView()
    }
}
extension UIView {
    func resizeToFitSubviews(_ tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.width
                let newHeight = aView.y + aView.height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        frame = CGRect(x: x, y: y, width: width, height: height)
    }
    func reorderSubViews(_ reorder: Bool = false, tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    someView.top = currentHeight
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
}
// MARK: Layer Extensions
extension UIView {
    func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width/2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    var backgroundColorAlpha:CGFloat {
        get {
            var a: CGFloat = 0
            self.backgroundColor?.getRed(nil, green: nil, blue: nil, alpha: &a)
            return a
        }
        set {
            self.backgroundColor = self.backgroundColor?.alpha(newValue)
        }
    }
    
    func addBorder(width: CGFloat = 1, color: UIColor = Color.boderLine) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
}
// MARK: Render Extensions
extension UIView {
    func toImage () -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
extension UIView {
    /// ZJaDe:  [UIRectCorner.TopLeft, UIRectCorner.TopRight]
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func roundView() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2
    }
}
extension UIView {
    func rootView() -> UIView {
        guard let parentView = superview else {
            return self
        }
        return parentView.rootView()
    }
    func viewController<T:UIViewController>(_ vcType:T.Type) -> T? {
        var responder = self.next
        repeat {
            if responder is T {
                return responder as? T
            }
            responder = responder?.next
        }while (responder != nil)
        return nil
    }
}
