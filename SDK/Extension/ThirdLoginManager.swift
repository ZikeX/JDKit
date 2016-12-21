//
//  ThirdLoginManager.swift
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

class ThirdLoginManager:NSObject {
    var authType:ThirdAuthType!
    
    func binding() {
        self.authType = .binding
        jumpAndAuth()
    }
    func loginAndAuth() {
        self.authType = .login
        jumpAndAuth()
    }
    func jumpAndAuth() {
        
    }
}
extension ThirdLoginManager {
    static func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        var result = false
        if result == false {
            if url.host == "oauth" {
                result = WXApi.handleOpen(url, delegate: WechatOAuthManager.shared)
            }
        }
        if result == false && TencentOAuth.canHandleOpen(url) {
            result = TencentOAuth.handleOpen(url)
        }
        if result == false {
            result = WeiboSDK.handleOpen(url, delegate: nil)
        }
        return result
    }
}
