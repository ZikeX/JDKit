//
//  BaseUserMainView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseUserMainView: UIView {
    lazy var backgroundImageView = ImageView(image: R.image.ic_mine_list_background())
    /// ZJaDe: 用户头像
    lazy var userPhoto:ImageView = {
        let imgView = ImageView()
        imgView.addBorder(color: Color.white)
        imgView.image = R.image.ic_default_userImg()
        let userPhotoLength = min(imgView.image!.size.width, imgView.image!.size.height)
        imgView.sizeValue(width: userPhotoLength, height: userPhotoLength)
        imgView.cornerRadius = userPhotoLength / 2
        return imgView
    }()
    
    lazy var mainStackView:UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit(){
        self.addSubview(backgroundImageView)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.edgesToView()
    }
}
