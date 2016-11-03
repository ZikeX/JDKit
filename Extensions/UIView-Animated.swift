
import UIKit

private let UIViewAnimationDuration: TimeInterval = 0.25
private let UIViewAnimationSpringDamping: CGFloat = 0.8
private let UIViewAnimationSpringVelocity: CGFloat = 10

// MARK: Animation Extensions
extension UIView {
    static func spring(duration:TimeInterval, animations: @escaping (() -> Void)) {
        self.spring(duration: duration, animations: animations, completion: nil)
    }
    static func spring(duration:TimeInterval, animations: @escaping (() -> Void), completion: ((Bool) -> Void)?) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.allowAnimatedContent,
            animations: animations,
            completion: completion
        )
    }
    
    func pop() {
        setScale(x: 1.1, y: 1.1)
        UIView.spring(duration: UIViewAnimationDuration, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }
    func popBig() {
        setScale(x: 1.25, y: 1.25)
        UIView.spring(duration: UIViewAnimationDuration, animations: { [unowned self] () -> Void in
            self.setScale(x: 1, y: 1)
            })
    }
    func zoomIn(_ animatedDuration:TimeInterval = UIViewAnimationDuration) {
        self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        self.alpha = 0
        UIView.animate(withDuration: animatedDuration, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        })
    }
    func zoomInOut(_ animatedDuration:TimeInterval = UIViewAnimationDuration, ZoomIn:Bool) {
        UIView.spring(duration: animatedDuration) {
            let scale:CGFloat = ZoomIn ? 0.95 : 1.0;
            self.layer.transform = CATransform3DMakeScale(scale, scale, scale);
        }
    }
    func shadow(_ animatedDuration:TimeInterval = UIViewAnimationDuration, isHighlighted:Bool,animated:Bool) {
        self.layer.shadowColor = Color.shadow.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 2)
        self.layer.shadowRadius = 3
        let shadowOpacity:Float = isHighlighted ? 0.25 : 0.0
        
        let animate = CABasicAnimation(keyPath: "shadowOpacity")
        animate.toValue = shadowOpacity
        animate.duration = animatedDuration
        animate.isRemovedOnCompletion = false
        animate.fillMode = kCAFillModeForwards
        self.layer.add(animate, forKey: "shadowOpacityAnimate")
    }
    func showOut(_ animatedDuration:TimeInterval = UIViewAnimationDuration) {
        self.layer.transform = CATransform3DMakeScale(1, 1, 0.1)
        self.alpha = 0
        UIView.animate(withDuration: animatedDuration, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        })
    }
}
extension UIView {
    func shakeViewForTimes(_ times: Int) {
        let anim = CAKeyframeAnimation(keyPath: "transform")
        anim.values = [
            NSValue(caTransform3D: CATransform3DMakeTranslation(-5, 0, 0 )),
            NSValue(caTransform3D: CATransform3DMakeTranslation( 5, 0, 0 ))
        ]
        anim.autoreverses = true
        anim.repeatCount = Float(times)
        anim.duration = 7/100
        
        self.layer.add(anim, forKey: nil)
    }
}
// MARK: Transform Extensions
extension UIView {
    func setRotationX(_ x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        self.layer.transform = transform
    }
    func setRotationY(_ y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        self.layer.transform = transform
    }
    func setRotationZ(_ z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    func setRotation(x: CGFloat, y: CGFloat, z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, x.degreesToRadians(), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, y.degreesToRadians(), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, z.degreesToRadians(), 0.0, 0.0, 1.0)
        self.layer.transform = transform
    }
    func setScale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}
