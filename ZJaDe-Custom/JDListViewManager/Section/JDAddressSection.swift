//
//  JDAddressSection.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDAddressSection: JDTableSection {
    lazy var locationModel:JDLabelModel = {
        let locationModel = JDLabelModel(title: "快速定位", detailTitle: "选择小区、大厦或者街道")
        self.configLocationCell(model: locationModel)
        return locationModel
    }()
    lazy var detailAddressModel:JDTextFieldModel = {
        let detailAddressModel = JDTextFieldModel(title: "详细地址", placeholder: "请填写商家详细地址")
        self.configDetailAddressCell(model: detailAddressModel)
        return detailAddressModel
    }()
    func addressModels() -> [JDFormModel] {
        return [locationModel,detailAddressModel]
    }
}
extension JDAddressSection {
    func configLocationCell(model:JDLabelModel) {
        configCell(model: model)
        model.reuseIdentifier = "LocationCell"
        model.accessoryType.value = .disclosureIndicator
        model.configBindingCell { (cell) in
            guard let cell = cell as? JDLabelCell else {
                return
            }
            cell.detailTitleLabel.textColor = Color.lightGray
            cell.detailTitleLabel.textAlignment = .left
            cell.touchCell = {
                RouterManager.push(.route_地图_定位)
            }
        }
    }
    func configDetailAddressCell(model:JDTextFieldModel) {
        self.configCell(model: model)
        model.reuseIdentifier = "DetailAddressCell"
    }
    func configCell(model:JDFormModel) {
        model.spaceEdges = UIEdgeInsetsMake(10, 10, 10, 10)
        model.cellHeight = 64
        model.titleRightSpace = 50
    }
}
