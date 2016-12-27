//
//  PageScrollView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//
import UIKit

class PageScrollView: UIScrollView {
    
    var imgArray = [ImageDataProtocol]() {
        didSet {
            self.totalPageNum = imgArray.count
            resetImages()
        }
    }
    private(set) var totalPageNum:Int = 0 {
        willSet {
            self.willChangeValue(forKey: "totalPageNum")
        }
        didSet {
            self.didChangeValue(forKey: "totalPageNum")
        }
    }
    /// ZJaDe: 从0开始算
    private var _currentPage:Int = 0
    var currentPage:Int {
        get {
            return _currentPage
        }
        set {
            self.willChangeValue(forKey: "currentPage")
            _currentPage = realIndex(newValue)
            self.didChangeValue(forKey: "currentPage")
            resetImages()
        }
    }
    func scrollToNextPage() {
        self.setContentOffset(CGPoint(x: self.width * 2, y: 0), animated: true)
        SwiftTimer.asyncAfter(seconds: 0.25) { 
            self.currentPage += 1
        }
    }
    func scrollToLastPage() {
        self.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        SwiftTimer.asyncAfter(seconds: 0.25) {
            self.currentPage -= 1
        }
    }
    // MARK: -
    fileprivate let imageViews:[ImageView] = {
        var array = [ImageView]()
        for index in 0..<3 {
            let imageView = ImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            array.append(imageView)
        }
        return array
    }()
    // MARK: -
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configInit()
    }
    func configInit() {
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.delegate = self
        self.imageViews.forEach { (imageView) in
            self.addSubview(imageView)
        }
    }
    // MARK: - 
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageViews.enumerated().forEach { (offset, element) in
            element.size = self.size
            element.left = offset.toCGFloat * self.width
        }
        self.contentSize = CGSize(width: self.width * 3, height: self.height)
    }
}
extension PageScrollView:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        
        if contentOffsetX < self.width * 0.5 {
            self.currentPage -= 1
        }else if contentOffsetX > self.width * 1.5 {
            self.currentPage += 1
        }else {
            self.resetContentOffsetX()
        }
    }
}
extension PageScrollView {
    func resetImages() {
        self.imageViews.enumerated().forEach { (offset,imageView) in
            let index = realIndex(currentPage + offset - 1)
            imageView.setImage(imageData: imgArray[index])
        }
        self.resetContentOffsetX()
    }
    func realIndex(_ index:Int) -> Int {
        return (index + totalPageNum) % totalPageNum
    }
    func resetContentOffsetX() {
        self.contentOffset.x = self.width
    }
}
