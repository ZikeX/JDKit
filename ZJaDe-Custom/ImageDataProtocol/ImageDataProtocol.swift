//
//  ImageDataProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//
import UIKit
private var UIImageViewActivityIndicatorKey: UInt8 = 0
extension UIImageView {
    fileprivate var activityIndicator:UIActivityIndicatorView? {
        get {
            return objc_getAssociatedObject(self, &UIImageViewActivityIndicatorKey) as? UIActivityIndicatorView
        }
        set {
            objc_setAssociatedObject(self, &UIImageViewActivityIndicatorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
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
        if self.activityIndicator != nil {
            self.activityIndicator?.removeFromSuperview()
            self.activityIndicator = nil
        }
    }
    func setImage(imageData:ImageDataProtocol?,placeholderImage:UIImage? = nil,style:UIActivityIndicatorViewStyle? = nil) {
        self.image = placeholderImage ?? R.image.ic_defalut_image()
        imageData?.injectImageToView(imageView:self,style: style)
    }
}

protocol ImageDataProtocol {
    func injectImageToView(imageView:UIImageView,style:UIActivityIndicatorViewStyle?)
}

extension String:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView,style:UIActivityIndicatorViewStyle? = nil) {
        let url = URL(string: self)
        if url != nil {
            url!.injectImageToView(imageView: imageView, style: style)
        }else {
            logError("\(self) -> 不是一个有效的URL")
        }
    }
}
extension URL:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView,style:UIActivityIndicatorViewStyle? = nil) {
        imageView.addActivityIndicator(style: style ?? .white)
        imageView.image = R.image.ic_defalut_image()
        imageView.removeActivityIndicator()
    }
}
extension UIImage:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView,style:UIActivityIndicatorViewStyle? = nil) {
        imageView.image = self
    }
}
