//
//  UserInfo.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import HandyJSON

class UserInfo {
    static let shared:UserInfo = UserInfo()
    lazy var personModel:PersonModel = {
        let personModel:PersonModel = self.readPersonModel()
        return personModel
    }()
    var loginModel:LoginModel = LoginModel()
    init() {
        self.configNotification()
    }
    deinit {
        self.removeNotification()
    }
    // MARK: - 
    func configNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(saveModel), name: .UIApplicationDidEnterBackground, object: nil)
    }
    func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidEnterBackground, object: nil)
    }
    @objc func saveModel() {
        self.savePersonModel()
    }
    // MARK: - 
    func checkAndLogin() {
        if self.loginModel.isLogined {
            let loginType = self.loginModel.loginType
            switch loginType {
            case .normalLogin:
                if let accountParams = self.getAccountParams() {
                    LoginModel.requestToLogin(loginType: loginType, params: accountParams, onlyRequest: true)
                }
            case .wechatLogin:
                WechatManager.shared.requestLogin(onlyRequest: true)
            case .qqLogin:
                QQManager.shared.requestLogin(onlyRequest: true)
            case .weiboLogin:
                WeiboManager.shared.requestLogin(onlyRequest: true)
            }
        }
    }
}
extension UserInfo {
    fileprivate func getFileName() -> String {
        return "personModel"
    }
    // MARK: -
    fileprivate func savePersonModel() {
        let result = NSKeyedArchiver.archiveRootObject(self.personModel.toSimpleDictionary(), toFile: self.getFilePath("personModel"))
        logInfo("保存PersonModel->\(result ? "成功" : "失败")")
    }
    fileprivate func readPersonModel() -> PersonModel {
        let dict = NSKeyedUnarchiver.unarchiveObject(withFile: self.getFilePath("personModel")) as? [String : Any]
        if let dict = dict {
            return PersonModel.createModel(dict: dict)
        }else {
            return PersonModel()
        }
    }
    fileprivate func getFilePath(_ fileName:String) -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!.appending("/\(fileName).src")
    }
}
