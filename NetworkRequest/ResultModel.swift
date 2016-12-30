//
//  ResultModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import HandyJSON

/// ZJaDe:-1[高级错误], 0[错误]，1[正确]，2[用户未注册]，3[用户未登录], 4[其它地方登陆], 5[有新版本]，6[当前版本过低]
enum ResultCode:Int {
    case error = -1
    case prompt = 0
    case successful
    case unregistered
    case needLogin
    case offline
    case newUpdateVersion
    case versionTooLow
}
extension ResultCode:HandyJSONEnum {
    static func makeInitWrapper() -> InitWrapperProtocol? {
        return InitWrapper<Int>(rawInit: ResultCode.init)
    }
}
class ResultModel:HandyJSON {
    var resultCode:ResultCode?
    var msg:String?
    required init() {
        
    }
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &resultCode, name: "result")
    }
    var isSuccessful:Bool {
        switch resultCode ?? .error {
        case .successful,.newUpdateVersion:
            return true
        default:
            return false
        }
    }
    var isOffline:Bool {
        return resultCode == .offline
    }
}
class DictResultModel:ResultModel {
    var data:Any!
}
class ObjectResultModel<Model>:ResultModel {
    var data:Model!
}
class ArrayResultModel<Model>:ResultModel {
    var data:[Model]!
}
