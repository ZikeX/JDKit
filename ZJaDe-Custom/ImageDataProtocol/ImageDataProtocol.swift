//
//  ImageDataProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//
import UIKit

extension UIImageView {
    func setImage(imageData:ImageDataProtocol?,defaultImage:UIImage? = nil) {
        if imageData == nil {
            self.image = defaultImage ?? R.image.ic_defalut_image()
        }else {
            imageData!.injectImageToView(imageView:self)
        }
    }
}

protocol ImageDataProtocol {
    func injectImageToView(imageView:UIImageView)
}

extension String:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView) {
        imageView.image = R.image.ic_defalut_image()
    }
}
extension URL:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView) {
        imageView.image = R.image.ic_defalut_image()
    }
}
extension UIImage:ImageDataProtocol {
    func injectImageToView(imageView: UIImageView) {
        imageView.image = self
    }
}
