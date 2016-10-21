//
//  JDButtonArrModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDButtonArrModel: JDFormModel {
    
    override func configModelInit() {
        super.configModelInit()
        autoAdjustHeight = true
    }
    var stackView = UIStackView(alignment: .fill, distribution: .fillEqually)
    var sizeScale:CGFloat = 3
    var maxColumn:Int = 0
    //最大可被选中的button的数量
    var maxSelectButtonCount:Int = 0
    var selectedButtonIndexs = [Int]()
    var dataArray:Variable<[(String?,UIImage?)]> = Variable([(String?,UIImage?)]())
    var buttonsSelectedAppearance:ButtonsSelectedAppearanceClosure = { (button,index,isSelected) in
        if isSelected {
            button.tintColor = Color.tintColor
            button.addBorder(color: Color.tintColor)
        }else {
            button.tintColor = Color.black
            button.addBorder(color: Color.black)
        }
        button.backgroundColor = Color.clear
    }
}

