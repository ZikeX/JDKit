//
//  JDCollectionView.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDCollectionView: UICollectionView {
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
