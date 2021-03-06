
import UIKit

extension UITextField {
    convenience init(text:String? = nil,placeholder:String? = nil,color:UIColor,font:UIFont) {
        self.init()
        self.text = text
        self.placeholder = placeholder
        self.textColor = color
        self.font = font
    }
    // MARK: -
    /// ZJaDe: Add left padding to the text in textfield
    func addLeftTextPadding(blankSize: CGFloat) {
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: blankSize, height: frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
    /// ZJaDe: Add a image icon on the left side of the textfield
    func addLeftIcon(image: UIImage?, frame: CGRect, imageSize: CGSize) {
        let leftView = UIView()
        leftView.frame = frame
        let imgView = ImageView()
        imgView.frame = CGRect(x: frame.width - 8 - imageSize.width, y: (frame.height - imageSize.height) / 2, width: imageSize.width, height: imageSize.height)
        imgView.image = image
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.always
    }

}
