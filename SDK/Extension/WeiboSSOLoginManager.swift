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
extension WeiboManager:WeiboSDKDelegate {
    func didReceiveWeiboRequest(_ request: WBBaseRequest!) {
        
    }
    func didReceiveWeiboResponse(_ response: WBBaseResponse!) {
        
    }
}
