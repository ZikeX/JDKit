//
//  BaseCollectionView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/9.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseCollectionView:JDCollectionView {
   
    
}
class BaseCollectionViewController: JDCollectionViewController {
    
    override func configInit() {
        super.configInit()
        self.baseVCConfigInit()
    }
}
