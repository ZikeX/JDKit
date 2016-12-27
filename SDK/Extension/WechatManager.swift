//
//  WXOAuthManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class WechatManager:ThirdManager {
    static let shared = WechatManager()
    private override init() {}
    override func jumpAndAuth() {
        guard WXApi.isWXAppSupport() else {
            Alert.showPrompt(title: "微信登录", "请检查是否已经安装微信客户端")
            return
        }
        let req = SendAuthReq()
        req.scope = WechatAuthScope
        req.openId = Defaults[.wx_openId]
        WXApi.sendAuthReq(req, viewController: jd.visibleVC(), delegate: self)
    }
}
extension WechatManager {
    override func requestLogin(needRefreshToken:Bool = true,onlyRequest:Bool = false) {
        func requestToLogin() {
            LoginModel.requestToLogin(loginType: .wechatLogin, onlyRequest: onlyRequest)
        }
        if needRefreshToken {
            self.wechatRefreshToken {
                requestToLogin()
            }
        }else {
            requestToLogin()
        }
    }
    fileprivate func requestToBinding() {
        LoginModel.requestToBindingWechat()
    }
}
extension WechatManager {
    fileprivate func wechatAccessToken(_ resp:SendAuthResp) {
        guard resp.errCode == 0 else {
            return
        }
        let hud = HUD.showMessage("获取微信登录参数中")
        _ = thirdAuthProvider.jd_request(.wechatAccessToken(code: resp.code)).mapJSON().subscribe(onNext:{[unowned self] (result) in
            hud.hide()
            guard let dict = result as? NSDictionary,dict[errcode_key] == nil else {
                Alert.showChoice(title: "微信登录", "获取微信登录参数出错，请重新获取授权", {
                    self.jumpAndAuth()
                })
                return
            }
            Defaults[.wx_access_token] = dict[access_token_key] as? String
            Defaults[.wx_refresh_token] = dict[refresh_token_key] as? String
            Defaults[.wx_openId] = dict[openId_key] as? String
            switch self.authType! {
            case .binding:
                self.requestToBinding()
            case .login:
                self.requestLogin(needRefreshToken:false)
            }
        })
    }
    fileprivate func wechatRefreshToken(_ callback:@escaping ()->()) {
        let hud = HUD.showMessage("刷新微信登录参数中")
        _ = thirdAuthProvider.jd_request(.wechatRefreshToken).mapJSON().subscribe(onNext:{ (result) in
            hud.hide()
            guard let dict = result as? NSDictionary,dict[errcode_key] == nil,dict[refresh_token_key] != nil else {
                Alert.showChoice(title: "微信登录", "微信登录失效，请重新获取授权", {
                    self.jumpAndAuth()
                })
                return
            }
            Defaults[.wx_access_token] = dict[access_token_key] as? String
            callback()
        })
    }
}
extension WechatManager:WXApiDelegate {
    // MARK: - delegate
    func onResp(_ resp: BaseResp!) {
        if let resp = resp as? SendAuthResp {
            // MARK: - 登录回调
            self.wechatAccessToken(resp)
        }
    }
}
