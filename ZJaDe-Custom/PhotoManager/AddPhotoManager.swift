//
//  AddPhotoManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import PermissionScope

typealias AddPhotoCallbackClosure = ([UIImage])->()

class AddPhotoManager {
    enum SelectImageType {
        case camera
        case photoAlbum
    }
    var selectImageType:SelectImageType!
    var callbackClosure:AddPhotoCallbackClosure!
    var maxImageCount:Int = 1
    
    
    // MARK: -
    lazy private(set) var assetGridVC:AssetGridViewController = {
        let viewCon = AssetGridViewController()
        return viewCon
    }()
    lazy private(set) var imagePicker:ImagePickerController = ImagePickerController()
    
    func config(_ closure:(AddPhotoManager)->()) -> Self {
        closure(self)
        return self
    }
    
    func callback(_ closure:@escaping AddPhotoCallbackClosure) -> Self {
        self.callbackClosure = closure
        return self
    }
    
    func show() {
        
        UIAlertController.actionSheet(title: "选择图片").addDefaultAction(title: "拍照") { (action) in
            let pscope = PermissionScope()
            pscope.addPermission(CameraPermission(), message: "如果拒绝将无法使用照相机功能")
            pscope.bodyLabel.text = "在您照相之前，app需要获取\r\niPhone的照相机权限"
            pscope.show({ (finished, results) in
                self.selectImageType = .camera
                RouterManager.present(self)
            }, cancelled: {(results) in
            })
        }.addDefaultAction(title: "从手机相册选择") { (action) in
            let pscope = PermissionScope()
            pscope.addPermission(PhotosPermission(), message: "如果拒绝将无法使用相册功能")
            pscope.bodyLabel.text = "在您选择相片之前，app需要获取\r\niPhone的访问相册的权限"
            pscope.show({ (finished, results) in
                self.selectImageType = .photoAlbum
                RouterManager.present(self)
                }, cancelled: {(results) in
            })
        }.show()
    }
}
extension AddPhotoManager:RouteUrlType {
    func createViewCon(_ manager: RouterManager) -> UIViewController? {
        switch self.selectImageType! {
        case .camera:
            self.imagePicker.callBack = callbackClosure
            return self.imagePicker
        case .photoAlbum:
            if self.maxImageCount <= 1 {
                self.imagePicker.callBack = callbackClosure
                return self.imagePicker
            }else {
                self.assetGridVC.maxImageCount = maxImageCount
                self.assetGridVC.callBack = callbackClosure
                return self.assetGridVC
            }
        }
    }
}
