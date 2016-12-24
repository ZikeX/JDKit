//
//  AddPhoto.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class AddPhoto {
    typealias AddPhotoCallbackClosure = ([UIImage])->()
    private(set) var callbackClosure:AddPhotoCallbackClosure?
    
    lazy private(set) var assetGridVC:AssetGridViewController = AssetGridViewController()
    lazy private(set) var imagePicker:UIImagePickerController = UIImagePickerController()
    
    func config(_ closure:(AddPhoto)->()) -> Self {
        closure(self)
        return self
    }
    
    func callback(_ closure:@escaping AddPhotoCallbackClosure) -> Self {
        self.callbackClosure = closure
        return self
    }
    
    func show() {
        RouterManager.present(self)
    }
}
extension AddPhoto:RouteUrlType {
    func createViewCon(_ manager: RouterManager) -> UIViewController? {
        return self.assetGridVC
    }
}
