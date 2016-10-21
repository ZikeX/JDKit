//
//  BaseCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/8.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class BaseCell: JDCustomCell {
}
// MARK: - ImagesCellProtocol
protocol ImagesCellProtocol:class {
    var imgsStackView:UIStackView? {get set}
    func createImgsStackView(count:Int,stackViewClosure:((UIStackView)->())?,imageViewClosure:((UIStackView,UIImageView)->())?)
    func configImgsStackView(itemArray:[ImageDataProtocol])
}
extension ImagesCellProtocol where Self:BaseCell {
    func createImgsStackView(count:Int,stackViewClosure:((UIStackView)->())? = nil,imageViewClosure:((UIStackView,UIImageView)->())? = nil) {
        let stackView = UIStackView(alignment: .fill, distribution:.equalCentering, spacing: 4)
        stackViewClosure?(stackView)
        for _ in 0..<count {
            let imageView = UIImageView()
            stackView.addArrangedSubview(imageView)
            imageViewClosure?(stackView,imageView)
        }
        self.imgsStackView = stackView
    }
    func configImgsStackView(itemArray:[ImageDataProtocol]) {
        for (index,imageView) in (imgsStackView!.arrangedSubviews as! [UIImageView]).enumerated() {
            itemArray[index].setImageInView(imageView: imageView)
        }
    }
}
