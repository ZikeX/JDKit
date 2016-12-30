//
//  AddPhotoManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import PermissionScope

typealias AddPhotoCallbackClosure = ([String],[UIImage])->()

class AddPhotoManager {
    // MARK: -
    enum SelectImageType {
        case camera
        case photoAlbum
    }
    fileprivate var selectImageType:SelectImageType = .camera
    var callbackClosure:AddPhotoCallbackClosure!
    var maxImageCount:Int = 1
    // MARK: -
    func config(_ closure:(AddPhotoManager)->()) -> Self {
        closure(self)
        return self
    }
    
    func callback(_ closure:@escaping AddPhotoCallbackClosure) -> Self {
        self.callbackClosure = closure
        return self
    }
    // MARK: -
    private var pscope:PermissionScope!
    func show() {
        pscope = PermissionScope()
        AlertController.actionSheet(title: "选择图片").addDefaultAction(title: "拍照") { (action) in
            self.pscope.addPermission(CameraPermission(), message: "如果拒绝将无法使用照相机功能")
            self.pscope.bodyLabel.text = "在您照相之前，app需要获取\r\niPhone的照相机权限"
            self.pscope.show({ (finished, results) in
                self.selectImageType = .camera
                RouterManager.present(self)
                self.pscope = nil
            }, cancelled: {(results) in
                self.pscope = nil
            })
        }.addDefaultAction(title: "从手机相册选择") { (action) in
            self.pscope.addPermission(PhotosPermission(), message: "如果拒绝将无法使用相册功能")
            self.pscope.bodyLabel.text = "在您选择相片之前，app需要获取\r\niPhone的访问相册的权限"
            self.pscope.show({ (finished, results) in
                self.selectImageType = .photoAlbum
                RouterManager.present(self)
                self.pscope = nil
            }, cancelled: {(results) in
                self.pscope = nil
            })
        }.show()
    }
}
extension AddPhotoManager:RouteUrlType {
    func createViewCon(_ manager: RouterManager) -> UIViewController? {
        let callbackClosure = self.callbackClosure!
        func imageToUrl(_ images:[UIImage]) {
            UIImage.jd_upload(images: images, closure: { (urlArr) in
                if let urlArr = urlArr {
                    callbackClosure(urlArr,images)
                }
            })
        }
        
        switch self.selectImageType {
        case .camera:
            let imagePicker = ImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.callBack = { (image) in
                imageToUrl([image])
            }
            return imagePicker
        case .photoAlbum:
            let assetGridVC = AssetGridViewController()
            assetGridVC.maxImageCount = maxImageCount <= 1 ? 1 : maxImageCount
            assetGridVC.callBack = { (images) in
                imageToUrl(images)
            }
            return assetGridVC
        }
    }
}
