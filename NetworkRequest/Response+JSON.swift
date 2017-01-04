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
private var ResponseVCKey:UInt8 = 0
extension Response:AssociatedObjectProtocol {
    weak var viewCon:BaseViewController? {
        get {
            return associatedObject(&ResponseVCKey)
        }
        set {
            setAssociatedWeakObject(&ResponseVCKey, newValue)
        }
    }
}
extension Response {
    func mapResult(_ sectionTitle:String?, showHUD:Bool) throws -> DictResultModel {
        debugSelf()
        guard let dict = try mapJSON() as? NSDictionary,let result = JSONDeserializer<DictResultModel>.deserializeFrom(dict:dict) else {
            throw Moya.Error.jsonMapping(self)
        }
        if result.isSuccessful {
            let data = dict["data"] as? [String:Any]
            if let sectionTitle = sectionTitle {
                result.data = data![sectionTitle]
            }else {
                result.data = data
            }            
        }
        
        handle(result, showHUD)
        return result
    }
    
    func mapObject<T: HandyJSON>(type: T.Type, _ sectionTitle:String, showHUD:Bool) throws -> ObjectResultModel<T> {
        debugSelf()
        guard let dict = try mapJSON() as? NSDictionary,let result = JSONDeserializer<ObjectResultModel<T>>.deserializeFrom(dict:dict) else {
            throw Moya.Error.jsonMapping(self)
        }
        result.data = JSONDeserializer<T>.deserializeFrom(dict: dict, designatedPath: "data.\(sectionTitle)")
        
        handle(result, showHUD)
        return result
    }
    func mapArray<T: HandyJSON>(type: T.Type, _ sectionTitle:String, showHUD:Bool) throws -> ArrayResultModel<T> {
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
        handle(result, showHUD)
        return result
    }
    
    func handle(_ result:ResultModel, _ showHUD:Bool) {
        let view = self.viewCon?.view
        switch result.resultCode ?? .prompt {
        case .successful,.newUpdateVersion:
            if showHUD {
                self.viewCon?.taskCenter.addTask({ (task) in
                    HUD.showSuccess(result.msg ?? "数据加载成功！", to: view)
                    task.end()
                })
            }
            if result.resultCode == .newUpdateVersion {
                AlertController.showChoice(title: "有新的版本", result.msg ?? "您有新的版本需要更新", { (action) in
                    // TODO: 这里跳转新版本
                })
            }
        case .offline:
            Alert.showPrompt(title:"账户验证", result.msg ?? "账号已被下线")
        case .needLogin:
            Alert.showChoice(title: "用户未登录", result.msg ?? "点击确定跳转登录", {
                RouterManager.present(Route_个人.登录)
            })
        case .unregistered:
            self.viewCon?.taskCenter.addTask({ (task) in
                HUD.showError(result.msg ?? "用户没有注册", to: view)
                task.end()
            })
        case .versionTooLow:
            AlertController.showPrompt(title: "版本过低", result.msg ?? "App版本过低", { (action) in
                exit(0)
            })
        case .error:
            Alert.showPrompt(title:"严重错误", result.msg ?? "请求出现严重错误")
        case .prompt:
            self.viewCon?.taskCenter.addTask({ (task) in
                HUD.showError(result.msg ?? "请求出现未知错误", to: view)
                task.end()
            })
        }
    }
    func debugSelf() {
        #if DEBUG
            let str = try? mapString()
            logDebug("获取到数据->\(str)")
        #endif
    }
}
