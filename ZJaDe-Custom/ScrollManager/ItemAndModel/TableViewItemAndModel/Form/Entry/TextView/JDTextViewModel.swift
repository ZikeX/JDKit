//
//  JDTextViewModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTextViewModel: JDEntryModel {
    var maxLength:Int?
    
    override func configModelInit() {
        super.configModelInit()
        self.cellHeight = 110
    }
    var contentSizeChanged = PublishSubject<(PlaceholderTextView,CGSize)>()
}
extension JDTextViewModel {
    func configTopTitleBottomTextViewModel() {
        self.spaceEdges = UIEdgeInsetsMake(10, 10, 10, 10)
        self.titleRightSpace = 15
        self.lineHeight = 0
        self.invalidateCellHeight()
        self.maxLength = 500
        let oldLayoutClosure = self.layoutCellClosure
        self.configLayoutCell { (cell) in
            oldLayoutClosure?(cell)
            guard let cell = cell as? JDTextViewCell else {
                return
            }
            cell.textViewItem.remakeLayoutView({ (view, maker) in
                maker.height_width(scale: 0.77)
                maker.left.right.bottom.equalToSuperview()
                maker.topSpace(cell.stackView)
            })
        }
    }
}
