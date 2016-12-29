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
    
    var hasPaypwd:Bool?
    
    var nickname:String = ""
    var username:String = ""
    var imgUrl:String = ""
    var gender:String?
    var birthday:String?
    
    var address:String = ""
    var province:String = ""
    var city:String = ""
    var area:String = ""
    var coordinate:CLLocationCoordinate2D?
    func provinceAddress() -> String {
        return self.province + self.city + self.area
    }
    
    var bindAccountMobile:Bool = false
    var bindAccountEmail:Bool = false
    var bindAccountWechat:Bool = false
    var bindAccountQQ:Bool = false
    var bindAccountWeibo:Bool = false
}
