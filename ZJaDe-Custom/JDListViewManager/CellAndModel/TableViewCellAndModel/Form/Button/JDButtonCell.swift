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
}
extension JDButtonCell {
    override func configCell(_ model: JDTableViewModel) {
        super.configCell(model)
        stackView.removeFromSuperview()
        button.edgesToView()
    }
    override func bindingModel(_ model: JDTableViewModel) {
        super.bindingModel(model)
        guard let buttonModel = model as? JDButtonModel else {
            return
        }
        buttonModel.title.asObservable().bindTo(button.textLabel.rx.text).addDisposableTo(disposeBag)
        buttonModel.image.asObservable().bindTo(button.imgView.rx.image).addDisposableTo(disposeBag)
        buttonModel.buttonAppearanceClosure(button)
        button.rx.tap.bindTo(buttonModel.buttonClick).addDisposableTo(disposeBag)
    }
}
