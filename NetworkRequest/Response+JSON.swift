//
//  Response+JSON.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

extension Response {
    func mapResult(_ sectionTitle:String?,showHUD:Bool) throws -> DictResultModel {
        debugSelf()
        guard let dict = try mapJSON() as? NSDictionary,let result = JSONDeserializer<DictResultModel>.deserializeFrom(dict:dict) else {
            throw Moya.Error.jsonMapping(self)
        }
        let data = dict["data"] as? [String:Any]
        if let sectionTitle = sectionTitle {
            result.data = data![sectionTitle] as! [String : String]
        }else {
            result.data = data as? [String : String]
        }
        
        handle(showHUD: showHUD, result: result)
        return result
    }
    
    func mapObject<T: HandyJSON>(type: T.Type, _ sectionTitle:String,showHUD:Bool) throws -> ObjectResultModel<T> {
        debugSelf()
        guard let dict = try mapJSON() as? NSDictionary,let result = JSONDeserializer<ObjectResultModel<T>>.deserializeFrom(dict:dict) else {
            throw Moya.Error.jsonMapping(self)
        }
        result.data = JSONDeserializer<T>.deserializeFrom(dict: dict, designatedPath: "data.\(sectionTitle)")
        
        handle(showHUD: showHUD, result: result)
        return result
    }
    func mapArray<T: HandyJSON>(type: T.Type, _ sectionTitle:String,showHUD:Bool) throws -> ArrayResultModel<T> {
        debugSelf()
        guard let dict = try mapJSON() as? NSDictionary,let result = JSONDeserializer<ArrayResultModel<T>>.deserializeFrom(dict:dict) else {
            throw Moya.Error.jsonMapping(self)
        }
        if let data = dict["data"] as? NSDictionary,let dataArray = data[sectionTitle] as? Array<NSDictionary> {
            var modelArray = [T]()
            for itemDict in dataArray {
                guard let model = JSONDeserializer<T>.deserializeFrom(dict: itemDict) else {
                    throw Moya.Error.jsonMapping(self)
                }
                modelArray.append(model)
            }
            result.data = modelArray
        }
        handle(showHUD: showHUD, result: result)
        return result
    }
    
    func handle(showHUD:Bool,result:ResultModel) {
        switch result.result ?? .prompt {
        case .successful,.newUpdateVersion:
            if showHUD {
                HUD.showSuccess(result.msg ?? "数据加载成功！")
            }
            if result.result! == .newUpdateVersion {
                Alert.showChoice(title:"有新的版本", result.msg!, { (index) in
                    // TODO: 这里跳转新版本
                })
            }
        case .offline:
            Alert.showPrompt(title:"账户验证", result.msg ?? "账号已被下线", { (index) in
                // TODO: 这里跳转登录
            })
        case .unregistered:
            HUD.showError(result.msg ?? "用户没有注册")
        case .versionTooLow:
            Alert.showPrompt(title:"版本过低", result.msg ?? "App版本过低", { (index) in
                exit(0)
            })
        case .error:
            Alert.showPrompt(title:"账户被禁止", result.msg ?? "账户已被禁止", { (index) in
                
            })
        case .prompt:
            HUD.showError(result.msg ?? "请求出现未知错误")
        }
    }
    func debugSelf() {
        #if DEBUG
            let str = try? mapString()
            logDebug("获取到数据->\(str)")
        #endif
    }
}
