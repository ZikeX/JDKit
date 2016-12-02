//
//  JDCollectionReusableView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDCollectionReusableView: UICollectionReusableView {
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
