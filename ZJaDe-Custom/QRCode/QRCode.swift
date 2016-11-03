//
//  QRCode.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/3.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class QRCode {
    // MARK:- 生成高清二维码图片
    static func image(qrString: String, sizeWH: CGFloat,logo:UIImage?) -> UIImage {
        let stringData = qrString.data(using: String.Encoding.utf8,
                                                    allowLossyConversion: false)
            // 创建一个二维码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")!
        qrFilter.setValue(stringData, forKey: "inputMessage")
        qrFilter.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter.outputImage
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        // 返回二维码image
        let codeImage = UIImage(ciImage: colorFilter.outputImage!
            .applying(CGAffineTransform(scaleX: sizeWH/23.0, y: sizeWH/23.0)))
        // 通常,二维码都是定制的,中间都会放想要表达意思的图片
        if let iconImage = UIImage.scaleTo(image: logo!, w: 50, h: 50).round(10) {
            let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
            
            UIGraphicsBeginImageContext(rect.size)
                 
            codeImage.draw(in: rect)
            let avatarSize = CGSize(width: rect.size.width * 0.25, height: rect.size.height * 0.25)
            let x = (rect.width - avatarSize.width) * 0.5
            let y = (rect.height - avatarSize.height) * 0.5
            iconImage.draw(in: CGRect(x:x, y:y, width:avatarSize.width, height:avatarSize.height))
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                 
            UIGraphicsEndImageContext()
            return resultImage!
        }
        return codeImage
    }
}
