
import UIKit

extension UIButton {
    func setBackgroundColor(_ color: UIColor?, forState state: UIControlState) {
        self.setBackgroundImage(UIImage.imageWithColor(color), for: state)
    }
    func changeToTemplate(isTemplate:Bool = true,color:UIColor?) {
        var image = self.imageView?.image
        image = isTemplate ? image?.templateImage : image?.originalImage
        self.setImage(image, for: .normal)
        self.tintColor = color
    }
}
