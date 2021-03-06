//
//  Observable+JSON.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import HandyJSON

extension ObservableType where E == Response {

    func mapResult(_ sectionTitle:String? = nil,showHUD:Bool = true) -> Observable<DictResultModel> {
        return filterSuccessfulStatusAndRedirectCodes().flatMap { response -> Observable<DictResultModel> in
            return Observable.just(try response.mapResult(sectionTitle, showHUD:showHUD))
        }
    }
    
    func mapObject<T: HandyJSON>(type: T.Type, _ sectionTitle:String,showHUD:Bool = false) -> Observable<ObjectResultModel<T>> {
        return filterSuccessfulStatusAndRedirectCodes().flatMap { response -> Observable<ObjectResultModel<T>> in
            return Observable.just(try response.mapObject(type: type, sectionTitle, showHUD:showHUD))
        }
    }
    
    func mapArray<T: HandyJSON>(type: T.Type, _ sectionTitle:String,showHUD:Bool = false) -> Observable<ArrayResultModel<T>> {
        return filterSuccessfulStatusAndRedirectCodes().flatMap { response -> Observable<ArrayResultModel<T>> in
            return Observable.just(try response.mapArray(type: type, sectionTitle, showHUD:showHUD))
        }
    }
    
}
extension ObservableType where E:ResultModel {
    func callback(_ closure:@escaping (E?)->()) -> Disposable {
        return self.subscribe(onNext: { (model) in
            closure(model)
        }, onError: { (error) in
            if let error = error as? Moya.Error {
                let view = error.response?.viewCon?.view
                switch error {
                case .statusCode(let response):
                    HUD.showError("数据出现错误，状态码为\(response.statusCode)", delay:10.0, to: view)
                case .jsonMapping(let response):
                    #if DEBUG
                        let str = try? response.mapString()
                        HUD.showError("数据格式错误->返回字符串为：\(str))", delay:10.0, to: view)
                    #else
                        HUD.showError("数据格式错误", to: view)
                    #endif
                case .imageMapping(let response):
                    #if DEBUG
                        HUD.showError("图片转换出现问题->\(response.debugDescription))", delay:10.0, to: view)
                    #else
                        HUD.showError("图片转换出现问题", to: view)
                    #endif
                case .stringMapping(_):
                    HUD.showError("字符串转换出现问题", to: view)
                case .data(let response):
                    #if DEBUG
                        HUD.showError("下载出现问题->\(response.debugDescription)", delay:10.0, to: view)
                    #else
                        HUD.showError("下载出现问题", to: view)
                    #endif
                default:
                    break
                }
            }
            closure(nil)
        }, onCompleted: {
            
        }, onDisposed: {
            
        })
    }
}
