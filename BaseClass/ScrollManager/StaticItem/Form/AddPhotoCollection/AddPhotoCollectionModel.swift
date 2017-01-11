//
//  AddPhotoCollectionModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/11.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class AddPhotoCollectionModel: JDFormModel {
    lazy var dataModel = Variable([AddPhotoModel]())
    
    var urlArray:[String] = [String]()
    
    override func configModelInit() {
        super.configModelInit()
        self.spaceEdges = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }
}
extension AddPhotoCollectionModel:CatchParamsProtocol,CheckParamsProtocol {
    func catchParams() -> [String : Any] {
        var params = [String:Any]()
        params[key] = urlArray
        return params
    }
    func checkParams() -> Bool {
        guard urlArray.count > 0 else {
            HUD.showPrompt("请上传图片")
            return false
        }
        return true
    }
}
