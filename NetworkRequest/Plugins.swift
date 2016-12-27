//
//  Plains.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/27.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import Moya
import Result

class ViewConPlugin:PluginType {
    weak var viewCon:BaseViewController?
    convenience init(_ viewCon:BaseViewController) {
        self.init()
        self.viewCon = viewCon
    }
    func willSendRequest(_ request: RequestType, target: TargetType) {
        
    }
    func didReceiveResponse(_ result: Result<Response, Moya.Error>, target: TargetType) {
        switch result {
        case .success(let response):
            response.viewCon = self.viewCon
        case .failure(let error):
            switch error {
            case .requestMapping(let url):
                self.viewCon?.taskCenter.addTask({ (task) in
                    #if DEBUG
                        HUD.showError("请求出错-->\(url)", delay:10.0, to: self.viewCon?.view)
                    #else
                        HUD.showError("请求出错", to: view)
                    #endif
                    task.end()
                })
            case .underlying(let error):
                self.viewCon?.taskCenter.addTask({ (task) in
                    HUD.showError(error.localizedDescription, to: self.viewCon?.view)
                    task.end()
                })
            default:
                error.response?.viewCon = self.viewCon
            }
        }
    }
}
