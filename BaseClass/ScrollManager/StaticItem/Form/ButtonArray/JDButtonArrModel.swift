//
//  JDButtonArrModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDButtonArrModel: JDFormModel {
    
    override func configModelInit() {
        super.configModelInit()
        self.enabled = false
    }
    var selectedButtonIndexs = [Int]() {
        didSet {
            selectedButtonsChanged.onNext(selectedButtonIndexs)
        }
    }
    var selectedButtonsChanged = PublishSubject<[Int]>()
    //最大可被选中的button的数量
    var maxSelectButtonCount:Int = 0
    var dataArray:Variable<[(String?,UIImage?)]> = Variable([(String?,UIImage?)]())
    
    typealias ButtonsSelectedAppearanceClosure = (Button) -> ()
    var buttonsSelectedAppearance:ButtonsSelectedAppearanceClosure = { (button) in
        if button.isSelected {
            button.tintColor = Color.tintColor
            button.addBorder(color: Color.tintColor)
        }else {
            button.tintColor = Color.black
            button.addBorder(color: Color.black)
        }
        button.backgroundColor = Color.clear
    }
}

