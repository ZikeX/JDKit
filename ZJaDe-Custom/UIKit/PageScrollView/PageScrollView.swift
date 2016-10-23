//
//  PageScrollView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/20.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//
import UIKit

class PageScrollView: UIScrollView {
    lazy var stackView:UIStackView = {
        let stackView = UIStackView(alignment: .fill, distribution: .fillEqually)
        self.addSubview(stackView)
        return stackView
    }()
    
    var imgArray = [ImageViewItemProtocol]() {
        didSet {
            stackView.snp.removeConstraints()
            stackView.edgesToView()
            stackView.snp.makeConstraints { (maker) in
                maker.height.equalTo(self)
                maker.width.equalTo(self).multipliedBy(imgArray.count)
            }
            stackView.removeAllSubviews()
            imgArray.forEach { (item) in
                stackView.addArrangedSubview(item.imageView)
            }
            self.totalPageNum = imgArray.count
        }
    }
    var totalPageNum:Int = 0 {
        willSet {
            self.willChangeValue(forKey: "totalPageNum")
        }
        didSet {
            self.didChangeValue(forKey: "totalPageNum")
        }
    }
    /// ZJaDe: 从0开始算
    var _currentPage:Int = 0
    var currentPage:Int {
        get {
            return _currentPage
        }
        set {
            self.willChangeValue(forKey: "currentPage")
            var newValue = newValue
            if newValue > totalPageNum - 1 {
                newValue = 0
            }
            if newValue < 0 {
                newValue = totalPageNum - 1
            }
            self.setContentOffset(CGPoint(x: newValue.toCGFloat * self.width, y: contentOffset.y), animated: true)
            _currentPage = newValue
            self.didChangeValue(forKey: "currentPage")
        }
    }
    func scrollToNextPage() {
        currentPage += 1
    }
    func scrollToLastPage() {
        currentPage -= 1
    }
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
    }
}
extension PageScrollView:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.currentPage = Int(scrollView.contentOffset.x / self.width)
    }
}
