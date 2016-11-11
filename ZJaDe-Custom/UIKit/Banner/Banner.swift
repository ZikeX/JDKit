//
//  Banner.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class Banner: UIView {
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let scrollView = PageScrollView()
    let pageControl = SnakePageControl()
    
    var dataArray:[ImageDataProtocol] = [ImageDataProtocol]() {
        didSet {
            self.scrollView.imgArray = dataArray
            self.pageControl.pageCount = dataArray.count
            self.pageControl.isHidden = dataArray.count <= 1
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
        let updateLayout = self.pageControl.updateLayout
        updateLayout.deactivate()
        updateLayout.constraintArr += self.pageControl.snp.prepareConstraints({ (maker) in
            maker.right.equalToSuperview().offset(-20)
            maker.bottom.equalToSuperview().offset(-10)
        })
        updateLayout.activate()
        
        self.scrollView.rx.contentOffset.subscribe { (event) in
            guard self.scrollView.width > 0 else {
                return
            }
            let page = self.scrollView.contentOffset.x / self.scrollView.width
            let progressInPage = self.scrollView.contentOffset.x - (page * self.scrollView.width)
            let progress = CGFloat(page) + progressInPage
            self.pageControl.progress = progress
        }.addDisposableTo(disposeBag)
        
        self.dataArray = [R.image.ic_defalut_image()!]
    }
}
