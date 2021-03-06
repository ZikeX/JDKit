//
//  Provider.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import HandyJSON

class RxJDProvider<Target: TargetType>: RxMoyaProvider<Target> {
    override init(endpointClosure: @escaping EndpointClosure = RxJDProvider.endpointMapping,
         requestClosure: @escaping RequestClosure = RxJDProvider.requestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = RxJDProvider.alamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, plugins: plugins, trackInflights: trackInflights)
    }
}

extension RxJDProvider {
    final class func endpointMapping(_ target: Target) -> Endpoint<Target> {
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        logDebug("请求地址:\(url)")
        return Endpoint(URL: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    }
    
    final class func requestMapping(_ endpoint: Endpoint<Target>, closure: RequestResultClosure) {
        if var request = endpoint.urlRequest {
            request.timeoutInterval = 20
            closure(.success(request))
        }else {
            closure(.failure(Moya.Error.requestMapping(endpoint.URL)))
        }
    }
    final class func alamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        
        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }
}
