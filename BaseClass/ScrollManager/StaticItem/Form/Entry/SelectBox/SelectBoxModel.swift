//
//  SelectBoxModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/11.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class SelectBoxModel: JDFormModel {
    lazy var hideButton:Button = {
        let button = Button(image:R.image.ic_下箭头(),isTemplate:true)
        button.tintColor = Color.black
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.sizeToFit()
        return button
    }()
    var titleArray = [String]()
    var isShowBox = Variable(false)
    var selectedButtonIndex:Int? {
        didSet {
            if let selectedButtonIndex = selectedButtonIndex {
                selectedButtonChanged.onNext(selectedButtonIndex)
            }
        }
    }
    var selectedButtonChanged = PublishSubject<Int>()
    
    override func configModelInit() {
        super.configModelInit()
        self.spaceEdges = UIEdgeInsets()
        self.invalidateCellHeight()
        self.hideButton.rx.touchUpInside {[unowned self] (button) in
            let show = !button.isSelected
            button.isSelected = show
            button.transform = show ? CGAffineTransform(rotationAngle: 180.toCGFloat.degreesToRadians()) : CGAffineTransform.identity
            self.isShowBox.value = show
        }
    }
}
