//
//  CollectionCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class CollectionCell: UICollectionViewCell {
    var enabled:Bool = true
    override init(frame: CGRect) {
        super.init(frame: frame)
        configItemInit()
        itemDidInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configItemInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        itemDidInit()
    }
}
