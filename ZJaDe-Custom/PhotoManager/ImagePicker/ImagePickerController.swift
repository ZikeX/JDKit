//
//  ImagePickerController.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/27.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import MobileCoreServices
class ImagePickerController: UIImagePickerController {
    var callBack:(UIImage)->() = { (image) in
        logDebug("回调没有写")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}
extension ImagePickerController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let type = info[UIImagePickerControllerMediaType] as? String, type == kUTTypeImage as String else {
            HUD.showError("您选择的不是图片")
            self.dismissVC()
            return
        }
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage,UIImagePNGRepresentation(image) != nil {
            self.callBack(image)
        }else {
            HUD.showError("您选择的图片的格式有问题，您可以重新尝试，或换张图片")
        }
        self.dismissVC()
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismissVC()
    }
}
