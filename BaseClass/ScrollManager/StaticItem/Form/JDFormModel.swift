//
//  JDFormModel.swift
//  TableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDFormModel: JDStaticModel {
    var layoutCellClosure:JDCellCompatibleType?
    var bindingCellClosure:JDCellCompatibleType?
    var updateEnabledStateClosure:JDUpdateEnabledStateType?
    
    
    var titleRightSpace:CGFloat = 8
    
    convenience init(image:UIImage? = nil,title:String? = nil) {
        self.init()
        self.title.value = title
        self.image.value = image
    }
    var accessoryType = Variable(UITableViewCellAccessoryType.none)
    var accessoryView:Variable<UIView?> = Variable(nil)
    var title:Variable<String?> = Variable(nil)
    var image:Variable<UIImage?> = Variable(nil)
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
