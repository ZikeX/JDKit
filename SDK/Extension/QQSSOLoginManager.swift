//
//  QQSSOLoginManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class QQSSOLoginManager:ThirdLoginManager {
    static let shared = QQSSOLoginManager()
    lazy var tencentOAuth:TencentOAuth = {
        let tencentOAuth = TencentOAuth(appId: TencentAppid, andDelegate: self)!
        tencentOAuth.openSDKWebViewQQShareEnable()
        return tencentOAuth
    }()
}
extension QQSSOLoginManager {
    override func jumpAndAuth() {
        guard ThirdPartyPermissions.canUseQQSSOLogin() else {
            Alert.showPrompt(title: "QQ登录", "请安装QQ客户端")
            return
        }
        let permissions = [kOPEN_PERMISSION_GET_USER_INFO,
                           kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                           kOPEN_PERMISSION_ADD_ONE_BLOG,
                           kOPEN_PERMISSION_ADD_SHARE,
                           kOPEN_PERMISSION_ADD_TOPIC,
                           kOPEN_PERMISSION_CHECK_PAGE_FANS,
                           kOPEN_PERMISSION_GET_INFO,
                           kOPEN_PERMISSION_GET_OTHER_INFO,
                           kOPEN_PERMISSION_LIST_ALBUM,
                           kOPEN_PERMISSION_UPLOAD_PIC,
                           kOPEN_PERMISSION_GET_VIP_INFO,
                           kOPEN_PERMISSION_GET_VIP_RICH_INFO]
        self.tencentOAuth.authorize(permissions)
    }
    fileprivate func requestLogin() {
        UserInfo.shared.loginModel.loginType = .qqLogin
        self.qqRefreshToken {
            var loginParams = LoginParams()
            loginParams.openid = Defaults[.qq_openId]
            loginParams.accessToken = Defaults[.qq_access_token]
            LoginModel.requestToLogin(params: loginParams, onlyRequest: false)
        }
    }
}
extension QQSSOLoginManager {
    fileprivate func qqRefreshToken(_ callback:@escaping ()->()) {
        guard let expirationDate = Defaults[.qq_expirationDate] else {
            Alert.showChoice(title: "QQ登录", "QQ登录出现问题，请重新获取授权", { (index) in
                self.jumpAndAuth()
            })
            return
        }
        guard expirationDate.compare(Date(timeIntervalSinceNow: -3600)) == .orderedAscending else {
            Alert.showChoice(title: "QQ登录", "QQ登录失效，请重新获取授权", { (index) in
                self.jumpAndAuth()
            })
            return
        }
        callback()
    }
}
extension QQSSOLoginManager:TencentSessionDelegate {
    func tencentDidLogin() {
        guard let accessToken = self.tencentOAuth.accessToken,accessToken.length > 0 else {
            return
        }
        Defaults[.qq_access_token] = self.tencentOAuth.accessToken
        Defaults[.qq_openId] = self.tencentOAuth.openId
        Defaults[.qq_expirationDate] = self.tencentOAuth.expirationDate
        switch self.authType! {
        case .binding:
            break
        case .login:
            self.requestLogin()
        }
    }
    func tencentDidNotLogin(_ cancelled: Bool) {
        
    }
    func tencentDidNotNetWork() {
        
    }
}
