//
//  LoginStateModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/17.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

enum LoginState:String {
    case noLogin
    case logining
    case logined
    case loginFailed
}
enum LoginType:String {
    case normalLogin
    case weChatLogin
    case qqLogin
    case weiboLogin
}
extension DefaultsKeys {
    static let loginState = DefaultsKey<String?>("loginState")
    static let loginType = DefaultsKey<String?>("loginType")
}
class LoginModel: BaseEntityModel {
    var loginState:LoginState {
        get {
            var _loginState:LoginState?
            if let existing = Defaults[.loginState] {
                _loginState = LoginState(rawValue: existing)
            }
            return _loginState ?? .noLogin
        }
        set {
            Defaults[.loginState] = newValue.rawValue
        }
    }
    var loginType:LoginType {
        get {
            var _loginType:LoginType?
            if let existing = Defaults[.loginType] {
                _loginType = LoginType(rawValue: existing)
            }
            return _loginType ?? .normalLogin
        }
        set {
            Defaults[.loginType] = newValue.rawValue
        }
    }
    
    var isLogined:Bool {
        return self.loginState == .logined
    }
}
extension LoginModel {
    static var isLogined:Bool {
        return UserInfo.shared.loginModel.isLogined
    }
    static func checkIsLogined() -> Bool {
        let isLogined = self.isLogined
        if !isLogined {
            Alert.showChoice(title: "您好", "您还没有登录，请登录之后再来操作，确认要登录吗？", { (index) in
                RouterManager.present(Route_个人.登录)
            })
        }
        return isLogined
    }
}
extension LoginModel {
    static func requestToLogin(loginType:LoginType,params:LoginParams? = nil, onlyRequest:Bool = false) {
        guard !(loginType == .normalLogin && params == nil) else {
            /// ZJaDe: 普通登录必须传进来参数
            return
        }
        UserInfo.shared.loginModel.loginType = loginType
        /// ZJaDe: 登录时如果传进来参数就用，没有的话说明是第三方登录；打开App时无论loginType是什么，都要传参数
        var paramsModel = LoginParams()
        if let params = params {
            paramsModel = params
        }else {
            switch loginType {
            case .normalLogin:
                break
            case .weChatLogin:
                paramsModel.refreshToken = Defaults[.wx_refresh_token]
                paramsModel.openid = Defaults[.wx_openID]
                paramsModel.accessToken = Defaults[.wx_access_token]
            case .qqLogin:
                paramsModel.openid = Defaults[.qq_openId]
                paramsModel.accessToken = Defaults[.qq_access_token]
            case .weiboLogin:
                paramsModel.openid = Defaults[.wb_userID]
                paramsModel.accessToken = Defaults[.wb_access_token]
            }
        }
        var hud:HUD?
        if !onlyRequest {
            UserInfo.shared.loginModel.loginState = .logining
            hud = HUD.showMessage("正在登录")
        }
        userAuthProvider.request(.login(loginParams: paramsModel)).mapObject(type: PersonModel.self, "userLogin",showHUD:true).callback { (result) in
            hud?.hide()
            if let result = result {
                self.userAuthCompleteHandle(result)
                if result.result == .unregistered {
                    RouterManager.push(Route_个人.注册(loginType))
                }
            }
        }
    }
    static func requestToRegister(loginType:LoginType, params:RegisterParams) {
        UserInfo.shared.loginModel.loginType = loginType
        /// ZJaDe: 注册时是拼接参数
        var paramsModel = params
        switch loginType {
        case .normalLogin:
            break
        case .weChatLogin:
            paramsModel.openid = Defaults[.wx_openID]
            paramsModel.accessToken = Defaults[.wx_access_token]
        case .qqLogin:
            paramsModel.openid = Defaults[.qq_openId]
            paramsModel.accessToken = Defaults[.qq_access_token]
        case .weiboLogin:
            paramsModel.openid = Defaults[.wb_userID]
            paramsModel.accessToken = Defaults[.wb_access_token]
        }
        
        UserInfo.shared.loginModel.loginState = .logining
        let hud = HUD.showMessage("注册中")
        userAuthProvider.request(.register(registerParams: paramsModel)).mapObject(type: PersonModel.self,"userReg",showHUD:true).callback({ (result) in
            hud.hide()
            if let result = result {
                self.userAuthCompleteHandle(result)
            }
        })
    }
    static func userAuthCompleteHandle(_ result:ObjectResultModel<PersonModel>) {
        if result.isSuccessful == true {
            UserInfo.shared.loginModel.loginState = .logined
            UserInfo.shared.personModel = result.data
            if jd.currentNavC != jd.appRootVC {
                jd.currentNavC.dismissVC()
            }
            
        }else {
            UserInfo.shared.loginModel.loginState = .loginFailed
        }
    }
}
