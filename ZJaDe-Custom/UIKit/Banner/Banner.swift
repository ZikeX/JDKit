//
//  Banner.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class Banner: UIView {
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let scrollView = PageScrollView()
    fileprivate let pageControl = SnakePageControl()
    
    var dataArray = [ImageDataProtocol]() {
        didSet {
            self.scrollView.imgArray = dataArray
            self.pageControl.pageCount = dataArray.count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.addSubview(self.scrollView)
        self.scrollView.edgesToView()
        self.addSubview(self.pageControl)
        self.pageControl.jdLayout
            .centerXAlign()
            .bottomAlign(offset: -10)
            .activate()
        
        self.scrollView.rx.contentOffset.subscribe { (event) in
            let page = self.scrollView.contentOffset.x / self.scrollView.bounds.width
            let progressInPage = self.scrollView.contentOffset.x - (page * self.scrollView.bounds.width)
            let progress = CGFloat(page) + progressInPage
            self.pageControl.progress = progress
        }.addDisposableTo(disposeBag)
    }
}
