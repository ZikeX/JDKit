//
//  ImagesCellAndModelProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
// MARK: - ImagesCellProtocol
protocol ImagesCellProtocol:class {
    var imgsStackView:UIStackView! {get set}
    func configImgsStackView(itemArray:[ImageDataProtocol])
}
extension ImagesCellProtocol where Self:BaseCell {
    /// ZJaDe: 代码创建ImgsStackView
    func createImgsStackView(count:Int,stackViewClosure:((UIStackView)->())? = nil,imageViewClosure:((UIStackView,UIImageView)->())? = nil) -> UIStackView {
        let stackView = UIStackView(alignment: .fill, distribution:.fillEqually, spacing: 4)
        stackViewClosure?(stackView)
        for _ in 0..<count {
            let imageView = UIImageView()
            stackView.addArrangedSubview(imageView)
            imageViewClosure?(stackView,imageView)
        }
        return stackView
    }
    /// ZJaDe: 配置数据
    func configImgsStackView(itemArray:[ImageDataProtocol]) {
        for (index,imageView) in (imgsStackView.arrangedSubviews as! [UIImageView]).enumerated() {
            if index < itemArray.count {
                imageView.setImage(imageData: itemArray[index])
            }else {
                imageView.image = nil
            }
        }
    }
}
// MARK: - ImagesModelProtocol
protocol ImagesModelProtocol {
    var imgDataArr:[ImageDataProtocol]? {set get}
    func configReuseIdentifier()
}
extension ImagesModelProtocol where Self:BaseModel {
    func configReuseIdentifier() {
        let count = self.imgDataArr?.count ?? 0
        if count > 0 {
            self.reuseIdentifier = "\(self.cellName)-Images"
        }else {
            self.reuseIdentifier = self.cellName
        }
    }
}
