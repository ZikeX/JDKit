
import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor?, forState state: UIControlState) {
        self.setBackgroundImage(UIImage.imageWithColor(color), for: state)
    }
}
