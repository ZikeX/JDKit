//
//  AssetGridModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/26.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import Photos

class AssetGridModel: BasePhotoModel {
    var asset:PHAsset!
    
    override var identity: Int {
        return asset.localIdentifier.hashValue
    }
}
