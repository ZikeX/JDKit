//
//  WXOAuthManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class WechatOAuthManager:ThirdLoginManager {
    static let shared = WechatOAuthManager()
}
extension WechatOAuthManager {
    override func jumpAndAuth() {
        guard ThirdPartyPermissions.canUseWechat() else {
            Alert.showPrompt(title: "微信登录", "请安装微信客户端")
            return
        }
        let req = SendAuthReq()
        req.scope = WechatAuthScope
        req.openID = Defaults[.wx_openID]
        WXApi.sendAuthReq(req, viewController: jd.visibleVC(), delegate: self)
    }
    
    fileprivate func requestLogin(needRefreshToken:Bool = true) {
        UserInfo.shared.loginModel.loginType = .weChatLogin
        func requestToLogin() {
            var loginParams = LoginParams()
            loginParams.refreshToken = Defaults[.wx_refresh_token]
            loginParams.openid = Defaults[.wx_openID]
            loginParams.accessToken = Defaults[.wx_access_token]
            LoginModel.requestToLogin(params: loginParams, onlyRequest: false)
        }
        if needRefreshToken {
            self.wechatRefreshToken {
                requestToLogin()
            }
        }else {
            requestToLogin()
        }
    }
    
}
extension WechatOAuthManager {
    fileprivate func wechatAccessToken(_ resp:SendAuthResp) {
        guard resp.errCode == 0 else {
            return
        }
        _ = thirdAuthProvider.request(.wechatAccessToken(code: resp.code)).mapJSON().subscribe(onNext:{[unowned self] (result) in
            guard let dict = result as? NSDictionary,dict[errcode_key] == nil else {
                return
            }
            Defaults[.wx_access_token] = dict[access_token_key] as? String
            Defaults[.wx_refresh_token] = dict[refresh_token_key] as? String
            Defaults[.wx_openID] = dict[openId_key] as? String
            switch self.authType! {
            case .binding:
                break
            case .login:
                self.requestLogin(needRefreshToken:false)
            }
        })
    }
    fileprivate func wechatRefreshToken(_ callback:@escaping ()->()) {
        _ = thirdAuthProvider.request(.wechatRefreshToken).mapJSON().subscribe(onNext:{ (result) in
            guard let dict = result as? NSDictionary,dict[errcode_key] == nil,dict[refresh_token_key] != nil else {
                Alert.showChoice(title: "微信登录", "微信登录失效，请重新获取授权", { (index) in
                    self.jumpAndAuth()
                })
                return
            }
            Defaults[.wx_access_token] = dict[access_token_key] as? String
            callback()
        })
    }
}
extension WechatOAuthManager:WXApiDelegate {
    // MARK: - delegate
    func onResp(_ resp: BaseResp!) {
        if let resp = resp as? SendAuthResp {
            self.wechatAccessToken(resp)
        }
    }
}
