//
//  NeedUpdateProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
protocol NeedUpdateProtocol:class {
    // MARK: - 设置刷新
    var needUpdate:Bool {get set}
    func setNeedUpdate()
}
extension NeedUpdateProtocol {
    func setNeedUpdate() {
        self.needUpdate = true
    }
}
extension JDModel:NeedUpdateProtocol {
    
}
