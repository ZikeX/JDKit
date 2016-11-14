//
//  UpdateModelProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
protocol UpdateModelProtocol:class {
    // MARK: - 设置刷新
    var needUpload:Bool {get set}
    func setNeedUpload()
}
extension UpdateModelProtocol {
    func setNeedUpload() {
        self.needUpload = true
    }
}
extension JDModel:UpdateModelProtocol {
    
}
