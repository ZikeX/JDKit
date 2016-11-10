//
//  ImageView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

    override init(image: UIImage?) {
        super.init(image: image)
        configInit()
    }
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    
    func configInit() {
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }

}
