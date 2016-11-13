//
//  ListModel+IdentifiableType.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

extension JDModel:IdentifiableType,Equatable,ClassNameProtocol {
    public static func ==(lhs: JDModel, rhs: JDModel) -> Bool {
        return lhs.classStr == rhs.classStr
    }

    var identity: String {
        return self.classStr
    }
}
extension JDTableViewSection:IdentifiableType,ClassNameProtocol {
    var identity:String {
        return self.classStr
    }
}
extension JDCollectionViewSection:IdentifiableType,ClassNameProtocol {
    var identity:String {
        return self.classStr
    }
}
