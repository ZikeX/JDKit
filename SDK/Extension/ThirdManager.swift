//
//  ThirdManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

enum ThirdAuthType {
    case binding
    case login
}

class ThirdManager:NSObject {
    var authType:ThirdAuthType!
    
    func binding() {
        self.authType = .binding
        self.jumpAndAuth()
    }
    func loginAndAuth() {
        self.authType = .login
        self.jumpAndAuth()
    }
    func jumpAndAuth() {
        
    }
    
    func requestLogin(needRefreshToken:Bool,onlyRequest:Bool) {
        
    }
}
extension ThirdManager {
    static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var result = false
        if result == false {
            result = WXApi.handleOpen(url, delegate: WechatManager.shared)
        }
        if result == false && TencentOAuth.canHandleOpen(url) {
            result = TencentOAuth.handleOpen(url)
        }
        if result == false {
            result = WeiboSDK.handleOpen(url, delegate: WeiboManager.shared)
        }
        return result
    }
}
