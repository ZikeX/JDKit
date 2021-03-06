
import Foundation
import UIKit

extension UIImage {
    var automaticImage:UIImage {
        return self.withRenderingMode(.automatic)
    }
    var templateImage:UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    var originalImage:UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
    func round(_ cornerRadius:CGFloat? = nil) -> UIImage {
        return self.scaleTo(size: self.size, cornerRadius: cornerRadius)
    }
    /// ZJaDe: scales image
    func scaleTo(size:CGSize,cornerRadius:CGFloat? = nil) -> UIImage {
        let layer = CALayer()
        layer.frame.size = size
        layer.contents = self.cgImage
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius ?? min(size.width, size.height)
        return type(of: self).getImage(layer, size: layer.frame.size)!
    }
    class func imageWithColor(_ color:UIColor?,size:CGSize = CGSize(width: 1,height: 1),cornerRadius:CGFloat? = 0) -> UIImage? {
        guard color != nil else {
            return nil
        }
        let layer = CALayer()
        layer.frame.size = size
        layer.backgroundColor = color!.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius ?? min(size.width, size.height)
        return self.getImage(layer, size: layer.frame.size)
    }
    class func getImage(_ layer:CALayer, size:CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
            UIGraphicsEndImageContext();
            return image
        }
        return nil
    }
}
extension UIImage {
    /// ZJaDe: Returns compressed image to rate from 0 to 1
    func compressImage(rate: CGFloat) -> Data? {
        return UIImageJPEGRepresentation(self, rate)
    }
    /// ZJaDe: Returns Image size in Bytes
    func getSizeAsBytes() -> Int {
        return UIImageJPEGRepresentation(self, 1)?.count ?? 0
    }
    /// ZJaDe: Returns Image size in Kylobites
    func getSizeAsKilobytes() -> Int {
        let sizeAsBytes = getSizeAsBytes()
        return sizeAsBytes != 0 ? sizeAsBytes / 1024 : 0
    }
    // MARK: -
    /// ZJaDe: Returns resized image with width. Might return low quality
    func resizeWithWidth(_ width: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: width, height: aspectHeightForWidth(width))
        
        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    /// ZJaDe: Returns resized image with height. Might return low quality
    func resizeWithHeight(_ height: CGFloat) -> UIImage {
        let aspectSize = CGSize (width: aspectWidthForHeight(height), height: height)
        
        UIGraphicsBeginImageContext(aspectSize)
        self.draw(in: CGRect(origin: CGPoint.zero, size: aspectSize))
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }
    /// ZJaDe: aspectHeightForWidth
    func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        return (width * self.size.height) / self.size.width
    }
    
    /// ZJaDe: aspectWidthForHeight
    func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        return (height * self.size.width) / self.size.height
    }
    
    
    /// ZJaDe: Returns the image associated with the URL
    convenience init?(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.init(data: Data())
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            print("EZSE: No image in URL \(urlString)")
            self.init(data: Data())
            return
        }
        self.init(data: data)
    }
    
    /// ZJaDe: Returns an empty image
    class func blankImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
