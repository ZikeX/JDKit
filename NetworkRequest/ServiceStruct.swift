//
//  JDService.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Moya

protocol ServiceStructProtocol:TargetType {
    var `struct`:ServiceStruct {get}
}
extension ServiceStructProtocol {
    var baseURL:URL {
        return self.struct.baseURL
    }
    var method:Moya.Method {
        return self.struct.method
    }
    var task: Task {
        return self.struct.task
    }
    var sampleData:Data {
        return self.struct.sampleData
    }
    var parameters: [String: Any]? {
        return self.struct.parameters
    }
    var path:String {
        return "/json/\(jd.appVersion)/" + self.struct.path
    }
}

struct ServiceStruct:TargetType {
    var baseURL = URL(string:appBaseURL)!
    var method:Moya.Method = .post
    var task: Task = .request
    var sampleData = Data()
    
    var path:String
    var parameters: [String: Any]?
    
    init(path:String, parameters:[String: Any]?) {
        self.path = path
        self.parameters = parameters
    }
}
