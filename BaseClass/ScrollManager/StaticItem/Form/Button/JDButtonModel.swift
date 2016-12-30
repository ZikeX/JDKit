//
//  JDButtonModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/3.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDButtonModel: JDFormModel {
    
    override func configModelInit() {
        super.configModelInit()
        cellHeight = 64
        
        spaceEdges = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
    }
    var buttonClick = PublishSubject<Void>()
}
extension JDButtonModel {
    func configWhiteBgButton(textColor:UIColor = Color.black) {
        self.cellHeight = 45
        let oldClosure = self.bindingCellClosure
        self.configBindingCell { (cell) in
            oldClosure?(cell)
            guard let cell = cell as? JDButtonCell else {
                return
            }
            cell.highlightAnimatedStyle = .shadow
            cell.backgroundColor = Color.white
            cell.button.then({ (button) in
                button.isUserInteractionEnabled = false
                button.backgroundColor = Color.clear
                button.textLabel.font = Font.h3
                button.tintColor = textColor
            })
        }
    }
}
