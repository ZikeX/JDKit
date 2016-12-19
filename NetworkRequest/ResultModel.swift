//
//  ResultModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import HandyJSON

enum ResultCode:Int {
    case error = 0
    case successful
    case offline
    case unregistered
    case newUpdateVersion
    case versionTooLow
}
extension ResultCode:HandyJSONEnum {
    static func makeInitWrapper() -> InitWrapperProtocol? {
        return InitWrapper<Int>(rawInit: ResultCode.init)
    }
}
class ResultModel:HandyJSON {
    /// ZJaDe: [0[错误]，1[正确]，2[帐户其它地方登陆], 3[QQ或微信帐户未注册]，4[有新版本]，5[当前版本过低]
    var result:ResultCode?
    var msg:String?
    required init() {
        
    }
    func mapping(mapper: HelpingMapper) {
        
    }
    var isSuccessful:Bool {
        switch result! {
        case .successful,.newUpdateVersion:
            return true
        default:
            return false
        }
    }
    var isOffline:Bool {
        return result! == .offline
    }
}

class ObjectResultModel<Model>:ResultModel {
    var data:Model?
}
class ArrayResultModel<Model>:ResultModel {
    var data:[Model]?
}
