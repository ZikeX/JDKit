//
//  ImageViewItemProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//
import UIKit

protocol ImageDataProtocol {
    func setImageInView(imageView:UIImageView)
}
/// ZJaDe: 根据url或者string或者image生成一个imageView
protocol ImageViewItemProtocol {
    var imageView:UIImageView {get}
}
extension String:ImageDataProtocol,ImageViewItemProtocol {
    var imageView: UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    func setImageInView(imageView: UIImageView) {
        imageView.image = R.image.ic_defalut_image()
    }
}
extension URL:ImageDataProtocol,ImageViewItemProtocol {
    var imageView: UIImageView {
        let imageView = UIImageView()
        return imageView
    }
    func setImageInView(imageView: UIImageView) {
        imageView.image = R.image.ic_defalut_image()
    }
    
}
extension UIImage:ImageDataProtocol,ImageViewItemProtocol {
    var imageView: UIImageView {
        let imageView = UIImageView()
        self.setImageInView(imageView: imageView)
        return imageView
    }
    func setImageInView(imageView: UIImageView) {
        imageView.image = self
    }
}
extension UIImageView:ImageViewItemProtocol {
    var imageView: UIImageView {
        return self
    }
}
