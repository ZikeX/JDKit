
import UIKit

#if os(iOS)

extension UISlider {
    
    func setValue(_ value: Float, duration: Double) {
      UIView.animate(withDuration: duration, animations: { () -> Void in
        self.setValue(self.value, animated: true)
        }, completion: { (bool) -> Void in
          UIView.animate(withDuration: duration, animations: { () -> Void in
            self.setValue(value, animated: true)
            }, completion: nil)
      }) 
    }
}

#endif
