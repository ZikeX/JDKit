//
//  AddressSection.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/25.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
class AddressComponentModel: BaseEntityModel {
    var province:String = ""
    var city:String = ""
    var area:String = ""
    var streetName:String = ""
    var streetNumber:String = ""
    
    var coordinate:CLLocationCoordinate2D?
    
    func detailAddress() -> String {
        return self.provinceAddress() + self.streetAddress()
    }
    func provinceAddress() -> String {
        return self.province + self.city + self.area
    }
    func areaAddress() -> String {
        return self.area + self.streetName + self.streetNumber
    }
    func streetAddress() -> String {
        return self.streetName + self.streetNumber
    }
}
class AddressSection: TableSection {
    var dataModel = AddressComponentModel()
    
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
        self.locationModel.detailTitle.value = self.dataModel.provinceAddress()
        self.detailAddressModel.text = self.dataModel.streetAddress()
    }
    func setValue(for personModel:PersonModel) {
        self.locationModel.detailTitle.value = personModel.provinceAddress()
        self.detailAddressModel.text = personModel.address
        self.dataModel.coordinate = personModel.coordinate
        self.dataModel.province = personModel.province
        self.dataModel.area = personModel.area
        self.dataModel.city = personModel.city
    }
}
extension AddressSection {
    func configLocationCell(model:JDLabelModel) {
        configCell(model: model)
        model.reuseIdentifier = "LocationCell"
        model.accessoryType.value = .disclosureIndicator
        model.configBindingCell {[unowned self] (cell) in
            guard let cell = cell as? JDLabelCell else {
                return
            }
            cell.detailTitleLabel.textColor = Color.lightGray
            cell.detailTitleLabel.textAlignment = .left
            cell.touchCell = {[unowned self] in
                RouterManager.push(Route_地图.定位({ (model) in
                    self.dataModel = model
                    self.updateData()
                }))
            }
        }
        model.configCheckParams({[unowned self] () -> Bool in
            guard self.dataModel.coordinate != nil else {
                HUD.showPrompt("请点击进行定位")
                return false
            }
            guard self.dataModel.province.length > 0 else {
                HUD.showPrompt("定位没有转换成地址，请重新尝试")
                return false
            }
            return true
        })
        model.configCatchParams({[unowned self] () -> [String : Any] in
            var params = [String : Any]()
            params["latitude"] = self.dataModel.coordinate?.latitude
            params["longitude"] = self.dataModel.coordinate?.longitude
            params["province"] = self.dataModel.province
            params["city"] = self.dataModel.city
            params["area"] = self.dataModel.area
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
        model.spaceEdges = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        model.cellHeight = 64
        model.titleRightSpace = 50
    }
}
