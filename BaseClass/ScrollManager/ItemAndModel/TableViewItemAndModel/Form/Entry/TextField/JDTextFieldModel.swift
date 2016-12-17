//
//  JDTextFieldModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextFieldModel: JDEntryModel {
    var entryType:EntryType?
    
    override func configModelInit() {
        super.configModelInit()
        self.cellHeight = 45
    }
    var textFieldEditingState = PublishSubject<UIControlEvents>()
}
extension JDTextFieldModel {
    func configColorTitleModel() {
        self.lineHeight = 0
        self.spaceEdges = UIEdgeInsetsMake(10, 10, 0, 10)
        self.reuseIdentifier = "titleCell"
        self.cellContentHeight = 44
        self.configBindingCell { (cell) in
            cell.titleLabel.font = Font.h4
            cell.titleLabel.textColor = Color.gray
            cell.titleLabel.textAlignment = .center
            cell.jdContentView.addBorderBottom(color:Color.tintColor)
            cell.stackView.addBorderBottom(color:Color.eggYellow)
        }
        self.configLayoutCell { (cell) in
            guard let cell = cell as? JDTextFieldCell else {
                return
            }
            cell.stackView.widthValue(width: 64)
        }
    }
}
