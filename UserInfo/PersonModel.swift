//
//  PersonModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/17.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit


class PersonModel: BaseEntityModel {
    var authToken:String?
    
    var hxcode:String = ""
    
    var email:String = ""
    var mobile:String = ""
    
    var hasPaypwd:Bool = false
    
    var nickname:String = ""
    var username:String = ""
    var imgUrl:String = ""
    var gender:String?
    var birthday:String?
    
    var shopAuditFailCause:String?
    var shopState:ShopState = .neverApply
    var shopAuditState:ShopAuditState = .neverApply
    
    var address:String = ""
    var province:String = ""
    var city:String = ""
    var area:String = ""
    var coordinate:CLLocationCoordinate2D? {
        get {
            if let latitude = latitude, let longitude = longitude {
                return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            }else {
                return nil
            }
        }
        set {
            latitude = newValue?.latitude
            longitude = newValue?.longitude
        }
    }
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    func provinceAddress() -> String {
        return self.province + self.city + self.area
    }
    
    var bindAccountMobile:Bool = false
    var bindAccountEmail:Bool = false
    var bindAccountWechat:Bool = false
    var bindAccountQQ:Bool = false
    var bindAccountWeibo:Bool = false
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        logDebug("找不到对应的key-->\(key),value:\(value)")
    }
}
