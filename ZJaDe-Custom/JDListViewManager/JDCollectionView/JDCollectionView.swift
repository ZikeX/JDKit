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
    var viewModel:JDCollectionViewModel! {
        didSet {
            viewModel.collectionView = self
            viewModel.configDataSource()
            viewModel.configDelegate()
        }
    }
    // MARK: - init
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    override init(frame: CGRect = CGRect(), collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.backgroundColor = Color.white
    }

}
