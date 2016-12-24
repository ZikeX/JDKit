//
//  ImageDataProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//
import UIKit
private var imageViewActivityIndicatorKey: UInt8 = 0
extension UIImageView {
    fileprivate var activityIndicator:UIActivityIndicatorView? {
        get {
            return associatedObject(&imageViewActivityIndicatorKey)
        }
        set {
            setAssociatedObject(&imageViewActivityIndicatorKey, newValue)
        }
    }
    fileprivate func addActivityIndicator(style:UIActivityIndicatorViewStyle) {
        if self.activityIndicator == nil {
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: style)
            
            Async.main {
                self.addSubview(self.activityIndicator!)
                self.activityIndicator!.edgesToView()
            }
        }
        Async.main {
            self.activityIndicator?.startAnimating()
        }
    }
    fileprivate func removeActivityIndicator() {
        self.activityIndicator?.removeFromSuperview()
        self.activityIndicator = nil
    }
    func setImage(imageData:ImageDataProtocol?,isUserImg:Bool = false,placeholderImage:UIImage? = nil,style:UIActivityIndicatorViewStyle? = nil) {
        
        self.image = placeholderImage ?? (isUserImg ? R.image.ic_default_userImg() : R.image.ic_default_image())
        imageData?.injectImageToView(imageView:self,isUserImg:isUserImg, style: style)
    }
}

protocol ImageDataProtocol {
    func injectImageToView(imageView:UIImageView,isUserImg:Bool, style:UIActivityIndicatorViewStyle?)
}

extension String:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView,isUserImg:Bool, style:UIActivityIndicatorViewStyle? = nil) {
        imageView.addActivityIndicator(style: style ?? .white)
        
        UIImage.jd_requestImage(url: self) { (image) in
            imageView.removeActivityIndicator()
            if let image = image {
                imageView.set(image: image, focusOnFaces: isUserImg)
            }else {
                if isUserImg {
                    imageView.image = R.image.ic_default_userImg()
                }else {
                    imageView.image = R.image.ic_default_image_failure()
                }
            }
        }
    }
}
//extension URL:ImageDataProtocol {
//    func injectImageToView(imageView: UIImageView,isUserImg:Bool, style:UIActivityIndicatorViewStyle? = nil) {
//    }
//}
extension UIImage:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView,isUserImg:Bool, style:UIActivityIndicatorViewStyle? = nil) {
        imageView.image = self
    }
}
