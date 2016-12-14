//
//  ImageArrView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/8.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class ImageArrView: CustomIBView {
    /// ZJaDe: height / width
    @IBInspectable var imageScale:CGFloat = 1.0 {
        didSet {
            self.updateHeightLayout()
        }
    }
    @IBInspectable var imageSpacing:CGFloat = 1.0 {
        didSet {
            self.updateHeightLayout()
        }
    }
    @IBInspectable var maxImageCount:Int = 3 {
        didSet {
            self.updateHeightLayout()
        }
    }
    /// ZJaDe: 配置数据
    var imgDataArray:[ImageDataProtocol]? {
        didSet {
            if self.imgDataArray?.count != oldValue?.count {
                self.updateHeightLayout()
            }else {
                self.configImgViews(imgDataArray)
            }
        }
    }
    lazy var itemArray = [ImageView]()
    // MARK: -
    var mainView = UIView()

    override func configInit() {
        super.configInit()
        self.addSubview(mainView)
        mainView.clipsToBounds = true
        
        self.snp.makeConstraints { (maker) in
            maker.height.equalTo(100)
        }
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: jd.screenWidth, height: 100)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
}
extension ImageArrView {
    func itemWidth() -> CGFloat {
        return (self.width - self.imageSpacing * (self.maxImageCount - 1).toCGFloat) / self.maxImageCount.toCGFloat
    }
    func itemHeight() -> CGFloat {
        return self.itemWidth() * self.imageScale
    }
    func updateHeightLayout() {
        self.snp.updateConstraints { (maker) in
            if self.isHidden {
                maker.height.equalTo(0)
            }else {
                maker.height.equalTo(self.itemHeight())
            }
        }
    }
    func updateFrame() {
        guard maxImageCount > 0 else {
            fatalError("图片最大数量必须大于0")
        }
        mainView.frame = self.bounds
        while itemArray.count != maxImageCount {
            if itemArray.count > maxImageCount {
                let lastItem = itemArray.removeLast()
                lastItem.removeFromSuperview()
            }else {
                let imageView = ImageView()
                imageView.contentMode = .scaleAspectFill
                mainView.addSubview(imageView)
                itemArray.append(imageView)
            }
        }
        let width = self.itemWidth()
        let height = self.itemHeight()
        itemArray.layoutItems { (preItem, item, index) in
            item.size = CGSize(width: width, height: height)
            if let preItem = preItem {
                item.left = preItem.right + self.imageSpacing
            }else {
                item.left = 0
            }
        }
        self.configImgViews(self.imgDataArray)
    }
    func configImgViews(_ itemDataArray:[ImageDataProtocol]?) {
        guard itemDataArray != nil && itemDataArray!.count > 0 else {
            self.isHidden = true
            self.updateHeightLayout()
            return
        }
        self.isHidden = false
        var imageDataCount = itemDataArray!.count
        if imageDataCount > self.maxImageCount {
            imageDataCount = self.maxImageCount
        }
        self.mainView.width = itemArray[imageDataCount - 1].right
        for (index,imageView) in itemArray.enumerated() {
            if index < imageDataCount {
                imageView.isHidden = false
                imageView.setImage(imageData: itemDataArray![index])
            }else {
                imageView.isHidden = true
            }
        }
    }
}
