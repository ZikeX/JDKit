//
//  LoginStateModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/17.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

enum LoginState {
    case noLogin
    case logining
    case logined
    case loginFailed
}
enum LoginType {
    case normalLogin
    case qqLogin
    case weChatLogin
}

class LoginModel: BaseEntityModel {
    var loginState:LoginState = .noLogin
    var loginType:LoginType = .normalLogin
    
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
    func requestToLogin(params:LoginParams,onlyRequest:Bool) {
        var hud:HUD?
        if !onlyRequest {
            UserInfo.shared.loginModel.loginState = .logining
            hud = HUD.showMessage("正在登录")
        }
        userAuthProvider.request(.login(loginParams: params)).mapObject(type: PersonModel.self, "userLogin",showHUD:true).callback { (result) in
            hud?.hide()
            if let result = result {
                self.userAuthCompleteHandle(result)
            }
        }
    }
    func requestToRegister(params:RegisterParams) {
        UserInfo.shared.loginModel.loginState = .logining
        let hud = HUD.showMessage("注册中")
        userAuthProvider.request(.register(registerParams: params)).mapObject(type: PersonModel.self,"userReg",showHUD:true).callback({ (result) in
            hud.hide()
            if let result = result {
                self.userAuthCompleteHandle(result)
            }
        })
    }
    func userAuthCompleteHandle(_ result:ObjectResultModel<PersonModel>) {
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
