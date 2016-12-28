//
//  AddressSection.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
class AddressDataModel: BaseEntityModel {
    var detailAddress:String = ""
    var province:String = ""
    var city:String = ""
    var area:String = ""
    var coordinate:CLLocationCoordinate2D?
    func provinces() -> String {
        return self.province + self.city + self.area
    }
}
class AddressSection: TableSection {
    var model = AddressDataModel()
    
    lazy var locationModel:JDLabelModel = {
        let locationModel = JDLabelModel(title: "快速定位", detailTitle: "选择小区、大厦或者街道")
        self.configLocationCell(model: locationModel)
        return locationModel
    }()
    lazy var detailAddressModel:JDTextFieldModel = {
        let detailAddressModel = JDTextFieldModel(title: "详细地址", placeholder: "请填写详细地址")
        self.configDetailAddressCell(model: detailAddressModel)
        return detailAddressModel
    }()
    func addressModels() -> [JDFormModel] {
        return [locationModel,detailAddressModel]
    }
    func updateData() {
        self.locationModel.detailTitle.value = self.model.provinces()
        self.detailAddressModel.text = self.model.detailAddress
    }
}
extension AddressSection {
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
            cell.touchCell = {[unowned self] in
                RouterManager.push(Route_地图.定位({ (model) in
                    self.model = model
                    self.updateData()
                }))
            }
        }
        model.configCheckParams({[unowned self] () -> Bool in
            guard self.model.coordinate != nil else {
                HUD.showPrompt("请点击进行定位")
                return false
            }
            guard self.model.province.length > 0 else {
                HUD.showPrompt("定位没有转换成地址，请重新尝试")
                return false
            }
            return true
        })
        model.configCatchParams({[unowned self] () -> [String : Any] in
            var params = [String : Any]()
            params["latitude"] = self.model.coordinate?.latitude
            params["longitude"] = self.model.coordinate?.longitude
            params["province"] = self.model.province
            params["city"] = self.model.city
            params["area"] = self.model.area
            return params
        })
    }
    func configDetailAddressCell(model:JDTextFieldModel) {
        self.configCell(model: model)
        model.reuseIdentifier = "DetailAddressCell"
        
        model.configCheckParams {[unowned model] () -> Bool in
            guard let text = model.text, text.length > 0 else {
                HUD.showPrompt(model.placeholder ?? "请把详细地址填写完整")
                return false
            }
            return true
        }
        model.configCatchParams {[unowned self] () -> [String : Any] in
            var params = [String : Any]()
            params["address"] = self.detailAddressModel.text
            return params
        }
    }
    func configCell(model:JDFormModel) {
        model.spaceEdges = UIEdgeInsetsMake(10, 10, 10, 10)
        model.cellHeight = 64
        model.titleRightSpace = 50
    }
}
