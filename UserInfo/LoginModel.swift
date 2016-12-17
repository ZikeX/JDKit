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
    
    var authToken:String?
}
