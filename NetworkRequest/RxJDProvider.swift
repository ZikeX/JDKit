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
protocol JDStructTargetProtocol {
    associatedtype StructType:TargetType
    var `struct`:StructType {get}
}
extension StructTarget:JDStructTargetProtocol {
    var `struct`: StructTarget {
        return self
    }
}
class RxJDProvider<Target>: RxMoyaProvider<Target.StructType> where Target: JDStructTargetProtocol {
    
    init(endpointClosure: @escaping EndpointClosure = RxJDProvider.endpointMapping,
         requestClosure: @escaping RequestClosure = RxJDProvider.requestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = RxJDProvider.alamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false,viewCon:BaseViewController? = nil) {
        var plugins = plugins
        if let plain = viewCon as? PluginType {
           plugins.append(plain)
        }
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, plugins: plugins, trackInflights: trackInflights)
    }
    func jd_request(_ token: Target) -> Observable<Response> {
        return self.request(token.struct)
    }
}
extension RxJDProvider where Target.StructType == StructTarget {
    func jd_request<T:JDStructTargetProtocol>(_ token: T) -> Observable<Response> {
        return self.request(StructTarget(token.struct))
    }
}
extension RxJDProvider {
    final class func endpointMapping(_ target: Target.StructType) -> Endpoint<Target.StructType> {
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        logDebug("请求地址:\(url)")
        return Endpoint(URL: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    }
    
    final class func requestMapping(_ endpoint: Endpoint<Target.StructType>, closure: RequestResultClosure) {
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
