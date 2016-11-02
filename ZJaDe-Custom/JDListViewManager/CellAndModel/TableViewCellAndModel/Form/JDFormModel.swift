//
//  JDFormModel.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

enum LabelAlignment {
    case center
    case top
}

class JDFormModel: JDTableViewModel {
    convenience init(image:UIImage? = nil,title:String? = nil) {
        self.init()
        self.title.value = title
        self.image.value = image
    }
    
    override func configModelInit() {
        super.configModelInit()
    }
    /*************** 附件类型 ***************/
    var accessoryType = Variable(UITableViewCellAccessoryType.none)
    
    var labelAlignment:LabelAlignment = .center
    
    var title:Variable<String?> = Variable(nil)
    var image:Variable<UIImage?> = Variable(nil)
    var stackViewWidth:CGFloat? = nil
    var titleLabelAppearanceClosure:LabelAppearanceClosure? = { (titleLabel) in
        titleLabel.textColor = Color.black
        titleLabel.font = Font.h3
        titleLabel.numberOfLines = 1
//        titleLabel.textAlignment = .right
    }
    var imageViewAppearanceClosure:ImgViewAppearanceClosure? = { (imgView) in
        
    }
}
extension JDFormModel {
    var titleIsEmpty:Bool {
        return self.title.value?.isEmpty != false
    }
    var imageIsEmpty:Bool {
        return self.image.value == nil
    }
    var imageSize:CGSize {
        if let size = self.image.value?.size {
            return size
        }else {
            return CGSize.zero
        }
    }
}
