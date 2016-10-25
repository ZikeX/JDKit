//
//  JDCollectionViewCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCellInit()
        cellDidInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configCellInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDidInit()
    }
    // MARK: - cell初始化
    func configCellInit() {
        
    }
    // MARK: - 做一些数据初始化
    func cellDidInit() {
        
    }
    func cellDidLoad(_ element: JDCollectionViewModel) {
        
    }
    final func cellWillAppear(_ element: JDCollectionViewModel) {
        self.configCellWithElement(element)
    }
    func configCellWithElement(_ element: JDCollectionViewModel) {
        
    }
    func cellDidDisappear(_ element: JDCollectionViewModel) {
        
    }
}
