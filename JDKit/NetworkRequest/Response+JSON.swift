//
//  Response+JSON.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/20.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

extension Response {
    
    func mapObject<T: HandyJSON>(type: T.Type) throws -> T {
        guard let dict = try mapJSON() as? NSDictionary,let object = JSONDeserializer<T>.deserializeFrom(dict:dict) else {
            throw Moya.Error.jsonMapping(self)
        }
        return object
    }
    
    func mapArray<T: HandyJSON>(type: T.Type) throws -> [T] {
        guard let objects = try mapJSON() as? Array<NSDictionary> else {
            throw Moya.Error.jsonMapping(self)
        }
        var modelArray = [T]()
        for dict in objects {
            guard let model = JSONDeserializer<T>.deserializeFrom(dict: dict) else {
                throw Moya.Error.jsonMapping(self)
            }
            modelArray.append(model)
        }
        return modelArray
    }
    
}
