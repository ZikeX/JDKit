//
//  CoreLaunch.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

enum CoreLaunchAnimateType {
    case Lite
}

class CoreLaunch {
    static var launchImage:UIImage? {
        let imageName:String
        switch UIScreen.main.bounds.size.height {
        case 480.0://3.5
            imageName = "LaunchImage-700"
        case 568.0:
            imageName = "LaunchImage-700-568h"
        case 667.0:
            imageName = "LaunchImage-800-667h"
        case 736.0:
            imageName = "LaunchImage-800-Portrait-736h"
        default:
            imageName = "LaunchImage-800-Portrait-736h"
        }
        let image = UIImage(named:imageName)
        if image == nil {
            logError("还没有添加启动图片");
        }
        return image
    }
    class func animate(window:UIWindow,image:UIImage? = nil,animateType:CoreLaunchAnimateType = .Lite) {
        guard let image = image ?? self.launchImage else {
            return
        }
        let imageView = ImageView(frame: UIScreen.main.bounds)
        imageView.image = image
        
        window.rootViewController?.view.addSubview(imageView)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: NSEC_PER_SEC/2)) {
            UIView.animate(withDuration: 1.0, animations: {
                switch animateType {
                case .Lite:
                    UIView.setAnimationCurve(.easeOut)
                    imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                    imageView.alpha = 0;                    
                }
            }, completion: { (finished) in
                    imageView.removeFromSuperview()
            })
        }
    }
}
