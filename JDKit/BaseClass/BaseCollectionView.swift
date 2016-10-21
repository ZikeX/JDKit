//
//  BaseCollectionView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseCollectionView: UICollectionView {
    convenience init() {
        let flowLayout = UICollectionViewFlowLayout()
        self.init(collectionViewLayout:flowLayout);
    }
    override init(frame: CGRect = CGRect(), collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configInit() {
        self.backgroundColor = Color.white
    }
}
