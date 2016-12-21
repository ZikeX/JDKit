//
//  DefaultsKeys+SDK.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

let openId_key:String = "openid"
let access_token_key:String = "access_token"
let refresh_token_key:String = "refresh_token"

//let unionid_key:String = "unionid"
let errcode_key:String = "errcode"

extension DefaultsKeys {
    // MARK: - wechat
    static let wx_refresh_token = DefaultsKey<String?>("wx_refresh_token")
    static let wx_access_token = DefaultsKey<String?>("wx_access_token")
    static let wx_openID = DefaultsKey<String?>("wx_openID")
//    static let wx_unionID = DefaultsKey<String?>("wx_unionID")
    // MARK: - QQ
    static let qq_access_token = DefaultsKey<String?>("qq_access_token")
    static let qq_openId = DefaultsKey<String?>("qq_openId")
    static let qq_expirationDate = DefaultsKey<Date?>("qq_expirationDate")
}
