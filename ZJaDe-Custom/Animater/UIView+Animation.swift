
import UIKit

extension UIView {
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
    func outwardFromCenter(_ animatedDuration:TimeInterval = UIViewAnimationDuration) {
        self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        self.alpha = 0
        UIView.animate(withDuration: animatedDuration, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        })
    }
    func touchZoomOut(_ animatedDuration:TimeInterval = UIViewAnimationDuration, _ touching:Bool) {
        UIView.spring(duration: animatedDuration) {
            let scale:CGFloat = touching ? 0.95 : 1.0;
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
    func fromInsideOut(_ animatedDuration:TimeInterval = UIViewAnimationDuration) {
        self.layer.transform = CATransform3DMakeScale(1, 1, 0.1)
        self.alpha = 0
        UIView.animate(withDuration: animatedDuration, animations: {
            self.alpha = 1
            self.layer.transform = CATransform3DIdentity
        })
    }
}


