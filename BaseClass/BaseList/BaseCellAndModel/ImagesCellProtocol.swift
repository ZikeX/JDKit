//
//  ImagesCellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
// MARK: - ImagesCellProtocol
protocol ImagesCellProtocol:class {
    var imgsView:ImageArrView! {get set}
}
// MARK: - ImagesModelProtocol
protocol ImagesModelProtocol {
    var imgDataArr:[ImageDataProtocol]? {set get}
}

