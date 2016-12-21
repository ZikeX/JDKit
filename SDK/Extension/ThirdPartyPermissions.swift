//
//  ThirdPartyPermissions.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/21.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import MessageUI

class ThirdPartyPermissions {
    // MARK: - Wechat
    static func canUseWechat() -> Bool {
        return WXApi.isWXAppInstalled()
    }
    // MARK: - QQ
    static func canUseQQ() -> Bool {
        return TencentOAuth.iphoneQQInstalled()
    }
    static func canUseQQSSOLogin() -> Bool {
        return TencentOAuth.iphoneQQSupportSSOLogin()
    }
    // MARK: - Weibo
    static func canUseWeibo() -> Bool {
        return WeiboSDK.isWeiboAppInstalled()
    }
    static func canUseWeiboShare() -> Bool {
        return WeiboSDK.isCanShareInWeiboAPP()
    }
    static func canUseWeiboSSO() -> Bool {
        return WeiboSDK.isCanSSOInWeiboApp()
    }
    // MARK: - Email
    static func canUseEmail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    // MARK: - Message
    static func canUseMessage() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
}
