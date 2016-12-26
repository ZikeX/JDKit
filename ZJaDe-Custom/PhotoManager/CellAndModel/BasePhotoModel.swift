//
//  BasePhotoModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/26.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift
class BasePhotoModel: BaseCollectionModel {
    var imageData:Variable<ImageDataProtocol?> = Variable(nil)
    
    convenience init(image:ImageDataProtocol) {
        self.init()
        self.imageData.value = image
    }
}
