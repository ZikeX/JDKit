//
//  ImagesCellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
// MARK: - ImagesCellProtocol
protocol ImagesCellProtocol:class {
    var imgsStackView:UIStackView! {get set}
    func configImgsStackView(itemArray:[ImageDataProtocol]?)
}
extension ImagesCellProtocol {
    /// ZJaDe: 代码创建ImgsStackView
    func createImgsStackView(count:Int,stackViewClosure:((UIStackView)->())? = nil,imageViewClosure:((UIStackView,ImageView)->())? = nil) -> UIStackView {
        let stackView = UIStackView(alignment: .fill, distribution:.fillEqually, spacing: 4)
        stackViewClosure?(stackView)
        for _ in 0..<count {
            let imageView = ImageView()
            stackView.addArrangedSubview(imageView)
            imageViewClosure?(stackView,imageView)
        }
        return stackView
    }
    /// ZJaDe: 配置数据
    func configImgsStackView(itemArray:[ImageDataProtocol]?) {
        guard itemArray != nil && itemArray!.count > 0 else {
            imgsStackView.isHidden = true
            return
        }
        imgsStackView.isHidden = false
        for (index,imageView) in (imgsStackView.arrangedSubviews as! [ImageView]).enumerated() {
            if index < itemArray?.count ?? -1 {
                //imageView.isHidden = false
                imageView.setImage(imageData: itemArray![index])
            }else {
                //imageView.isHidden = true
                imageView.image = nil
            }
        }
    }
}
// MARK: - ImagesModelProtocol
protocol ImagesModelProtocol {
    var imgDataArr:[ImageDataProtocol]? {set get}
}

