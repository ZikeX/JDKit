//
//  LocalDataArrayProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
protocol LocalDataArrayProtocol {
    associatedtype ListViewType:UpdateDataSourceProtocol
    var listView:ListViewType {get}
    
    typealias DataArrayType = ListViewType.DataArrayType
    typealias SectionType = ListViewType.SectionType
    typealias ModelType = ListViewType.ModelType
    
    func getLocalSectionModels() -> DataArrayType?
    func loadLocalSectionModels()
}
extension LocalDataArrayProtocol {
    final func loadLocalSectionModels() {
        self.listView.updateDataSource({ (oldDataArray) -> DataArrayType? in
            return self.getLocalSectionModels()
        })
    }
}
extension JDTableView:LocalDataArrayProtocol {
    typealias ListViewType = JDTableView
    var listView: ListViewType {
        return self
    }
}
extension JDTableViewController:LocalDataArrayProtocol {
    typealias ListViewType = JDTableView
    var listView: ListViewType {
        return self.jdTableView
    }
}
extension JDCollectionView:LocalDataArrayProtocol {
    typealias ListViewType = JDCollectionView
    var listView: ListViewType {
        return self
    }
}
extension JDCollectionViewController:LocalDataArrayProtocol {
    typealias ListViewType = JDCollectionView
    var listView: ListViewType {
        return self.jdCollectionView
    }
}
