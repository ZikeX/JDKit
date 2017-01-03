//
//  ImageView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    override var image: UIImage? {
        get {
            return super.image
        }
        set {
            self.willChangeValue(forKey: "image")
            if newValue?.size == CGSize() {
                super.image = newValue
            }else if isTemplate == true {
                super.image = newValue?.templateImage
            }else {
                super.image = newValue?.originalImage
            }
            self.didChangeValue(forKey: "image")
        }
    }
    @IBInspectable var isTemplate: Bool = false {
        didSet {
            let image = self.image
            self.image = image
        }
    }
    
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
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configInit() {
        self.clipsToBounds = true
    }
}
