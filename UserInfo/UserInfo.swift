//
//  UserInfo.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class UserInfo {
    static let shared:UserInfo = UserInfo()
    var personModel:PersonModel = PersonModel()
    var loginModel:LoginModel = LoginModel()
}
