//
//  LocalDataArrayProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
protocol LocalDataArrayProtocol:UpdateDataSourceProtocol {
    func getLocalSectionModels() -> DataArrayType?
    func loadLocalSectionModels()
}
extension LocalDataArrayProtocol {
    final func loadLocalSectionModels() {
        self.updateDataSource({ (oldDataArray) -> DataArrayType? in
            return self.getLocalSectionModels()
        })
    }
}
extension JDTableViewModel:LocalDataArrayProtocol {

}
extension JDCollectionViewModel:LocalDataArrayProtocol {
    
}
