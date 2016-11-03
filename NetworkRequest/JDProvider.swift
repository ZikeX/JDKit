//
//  JDProvider.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import Moya

class JDProvider: MoyaProvider<JDServiceType> {
    init(endpointClosure: @escaping EndpointClosure = JDProvider.JDEndpointMapping,
         requestClosure: @escaping RequestClosure = JDProvider.JDRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, plugins: plugins, trackInflights: trackInflights)
    }
}
extension JDProvider {
    typealias Target = JDServiceType
    final class func JDEndpointMapping(_ target: Target) -> Endpoint<Target> {
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        return Endpoint(URL: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    }
    
    final class func JDRequestMapping(_ endpoint: Endpoint<Target>, closure: RequestResultClosure) {
        if var request = endpoint.urlRequest {
            request.timeoutInterval = 20
            closure(.success(request))
        }else {
            closure(.failure(Moya.Error.requestMapping(endpoint.URL)))
        }
    }
}
