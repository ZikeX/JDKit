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
    static func image(qrString: String, imageSize: CGFloat, logo:UIImage? = nil, fillColor:UIColor = Color.darkBlack, backColor:UIColor = Color.white) -> UIImage? {
        guard qrString.length > 0 && imageSize > 10 else {
            return nil
        }
        let stringData = qrString.data(using: String.Encoding.utf8)
        /// ZJaDe: 生成
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")!;
        qrFilter.setValue(stringData, forKey: "inputMessage")
        qrFilter.setValue("M", forKey: "inputCorrectionLevel")
        
        /// ZJaDe: 上色
        let colorFilter = CIFilter(name: "CIFalseColor", withInputParameters: ["inputImage":qrFilter.outputImage!,"inputColor0":CIColor(cgColor: fillColor.cgColor),"inputColor1":CIColor(cgColor: backColor.cgColor)])!
        
        let qrImage = colorFilter.outputImage!
        
        /// ZJaDe: 绘制
        let imgSize = CGSize(width:imageSize, height:imageSize);
        let cgImage = CIContext().createCGImage(qrImage, from: qrImage.extent)!
        UIGraphicsBeginImageContext(imgSize)
        let context = UIGraphicsGetCurrentContext()!
        context.interpolationQuality = .none
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: context.boundingBoxOfClipPath)
        let codeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        /// ZJaDe:subImage
        if let subImage = logo {
            return self.addSubImage(image: codeImage!, subImage: subImage)
        }
        return codeImage
    }
    // MARK:- 从图片中读取二维码
    static func scan(qrImage:UIImage) -> String? {
        let context = CIContext()
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        let image = CIImage.init(cgImage: qrImage.cgImage!)
        let features = detector?.features(in: image)
        let feature = features?.first as? CIQRCodeFeature
        let result = feature?.messageString
        return result
    }
}

extension QRCode {
    static func addSubImage(image:UIImage,subImage:UIImage) -> UIImage {
        let width:Int = Int(image.size.width)
        let height:Int = Int(image.size.height)
        let subWidth:Int = Int(subImage.size.width)
        let subHeight:Int = Int(subImage.size.height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext.init(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4*width, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)!
        context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: width, height: height))
        context.draw(subImage.cgImage!, in: CGRect(x: (width-subWidth)/2, y: (height - subHeight)/2, width: subWidth, height: subHeight))
        return UIImage(cgImage: context.makeImage()!)
    }
}
