//
//  WeiboManager.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class WeiboManager: ThirdManager {
    static let shared = WeiboManager()
    
    override func jumpAndAuth() {
        let request = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        request.redirectURI = WeiboRedirectURI
        request.scope = WeiboScope
        WeiboSDK.send(request)
    }
}
extension WeiboManager {
    func requestLogin() {
        UserInfo.shared.loginModel.loginType = .weiboLogin
        self.weiboRefreshToken {
            var loginParams = LoginParams()
            loginParams.openid = Defaults[.wb_userID]
            loginParams.accessToken = Defaults[.wb_access_token]
            loginParams.refreshToken = Defaults[.wb_refresh_token]
            LoginModel.requestToLogin(params: loginParams, onlyRequest: false)
        }
    }
}
extension WeiboManager {
    fileprivate func weiboRefreshToken(_ callback:@escaping ()->()) {
        guard let expirationDate = Defaults[.wb_expirationDate] else {
            Alert.showChoice(title: "微博登录", "微博登录出现问题，请重新获取授权", { (index) in
                self.jumpAndAuth()
            })
            return
        }
        guard expirationDate > Date(timeIntervalSinceNow: -3600) else {
            let hud = HUD.showMessage("获取微博登录参数中")
            _ = WBHttpRequest(forRenewAccessTokenWithRefreshToken: Defaults[.wb_refresh_token], queue: nil, withCompletionHandler: { (request, result, error) in
                hud.hide()
                guard error == nil else {
                    Alert.showChoice(title: "微博登录", "微博登录失效，请重新获取授权", { (index) in
                        self.jumpAndAuth()
                    })
                    return
                }
                logDebug(result!)
            })
            return
        }
        callback()
    }
}
extension WeiboManager:WeiboSDKDelegate {
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        if let response = response as? WBAuthorizeResponse {
            // MARK: - 登录回调
            Defaults[.wb_userID] = response.userID
            Defaults[.wb_access_token] = response.accessToken
            Defaults[.wb_refresh_token] = response.refreshToken
            Defaults[.wb_expirationDate] = response.expirationDate
            switch self.authType! {
            case .binding:
                break
            case .login:
                self.requestLogin()
            }
        }
    }
}
