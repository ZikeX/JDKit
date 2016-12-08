//
//  ImageArrView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/8.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class ImageArrView: CustomIBView {
    /// ZJaDe: height / width
    @IBInspectable var imageScale:CGFloat = 1.0 {
        didSet {
            self.updateLayout()
        }
    }
    @IBInspectable var imageSpacing:CGFloat = 1.0 {
        didSet {
            self.stackView.spacing = imageSpacing
            self.updateLayout()
        }
    }
    @IBInspectable var maxImageCount:Int = 3 {
        didSet {
            self.updateLayout()
        }
    }
    // MARK: -
    var mainView = UIView()
    fileprivate var stackView:UIStackView = {
        let stackView = UIStackView(alignment: .fill, distribution:.fillEqually, spacing: 1.0)
        return stackView
    }()
    override func configInit() {
        super.configInit()
        self.addSubview(mainView)
        mainView.clipsToBounds = true
        mainView.snp.makeConstraints { (maker) in
            maker.top.centerY.left.equalToSuperview()
            maker.right.equalToSuperview().priority(900)
        }
        mainView.addSubview(stackView)
        stackView.edgesToView()
    }
    
    /// ZJaDe: 配置数据
    var imgDataArray:[ImageDataProtocol]? {
        didSet {
            updateLayout()
        }
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: jd.screenWidth, height: 100)
    }
}
extension ImageArrView {
    func updateLayout() {
        guard maxImageCount > 0 else {
            fatalError("图片最大数量必须大于0")
        }
        while stackView.arrangedSubviews.count != maxImageCount {
            if stackView.arrangedSubviews.count > maxImageCount {
                stackView.removeArrangedSubview(stackView.arrangedSubviews.last!)
            }else {
                let imageView = ImageView()
                imageView.contentMode = .scaleAspectFill
                if stackView.arrangedSubviews.count == 0 {
                    imageView.tag = 10
                }
                stackView.addArrangedSubview(imageView)
            }
        }
        let firstImageView = stackView.viewWithTag(10)!
        firstImageView.snp.remakeConstraints { (maker) in
            maker.height_width(scale: self.imageScale)
            let offset = self.imageSpacing * (1 - maxImageCount).toCGFloat / maxImageCount.toCGFloat
            maker.width.equalTo(self).dividedBy(maxImageCount).offset(offset).priority(999)
        }
        self.configImgViews(self.imgDataArray)
    }
    func configImgViews(_ itemArray:[ImageDataProtocol]?) {
        guard itemArray != nil && itemArray!.count > 0 else {
            self.isHidden = true
            return
        }
        self.isHidden = false
        let imageDataCount = itemArray!.count
        let images = stackView.arrangedSubviews as! [ImageView]
        for (index,imageView) in images.enumerated() {
            if index < imageDataCount {
                imageView.isHidden = false
                imageView.setImage(imageData: itemArray![index])
            }else {
                imageView.isHidden = true
            }
        }
    }
}
