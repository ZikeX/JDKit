//
//  JDButtonCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/3.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDButtonCell: JDFormCell {
    var button = Button()
    
    override func configCellInit() {
        super.configCellInit()
        jdContentView.addSubview(button)
    }
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        stackView.removeFromSuperview()
        button.edgesToView()
    }
    override func configCellWithElement(_ element: JDTableViewModel) {
        guard let buttonModel = element as? JDButtonModel else {
            return
        }
        buttonModel.title.asObservable().bindTo(button.textLabel.rx.text).addDisposableTo(disposeBag)
        buttonModel.image.asObservable().bindTo(button.imgView.rx.image).addDisposableTo(disposeBag)
        buttonModel.buttonAppearanceClosure(button)
        button.rx.tap.bindTo(buttonModel.buttonClick).addDisposableTo(disposeBag)
    }
}
