//
//  JDCollectionView.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDCollectionView: UICollectionView {
    
    let viewModel:JDCollectionViewModel
    init(viewModel:JDCollectionViewModel) {
        self.viewModel = viewModel
        super.init(frame: jd.screenBounds, collectionViewLayout: self.viewModel.layout)
        viewModel.collectionView = self
        viewModel.configDataSource()
        viewModel.configDelegate()
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("暂不支持xib")
    }
    func configInit() {
        self.backgroundColor = Color.white
    }
    deinit {
        logDebug("\(type(of:self))->\(self)注销")
    }
}
