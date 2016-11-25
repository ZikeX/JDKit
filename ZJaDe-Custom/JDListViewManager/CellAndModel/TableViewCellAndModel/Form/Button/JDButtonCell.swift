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
        self.jdFocusView = button
        jdContentView.addSubview(button)
    }
}
extension JDButtonCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
        stackView.removeFromSuperview()
        button.edgesToView()
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let buttonModel = model as? JDButtonModel else {
            return
        }
        self.configButton(button)
        buttonModel.title.asObservable().subscribe(onNext:{[unowned self] (title) in
            self.button.textStr = title
        }).addDisposableTo(disposeBag)
        
        buttonModel.image.asObservable().subscribe(onNext:{[unowned self] (image) in
            self.button.img = image
        }).addDisposableTo(disposeBag)
        
        button.rx.tap.bindTo(buttonModel.buttonClick).addDisposableTo(disposeBag)
    }
    override func updateEnabledState(_ model: JDTableModel, enabled: Bool) {
        super.updateEnabledState(model, enabled: enabled)
        self.button.isEnabled = enabled
    }
}
extension JDButtonCell {
    func configButton(_ button:Button) {
        button.backgroundColor = Color.tintColor
        button.cornerRadius = 5
        button.tintColor = Color.white
        button.textLabel.font = Font.h2
        button.addHighlightedShadowAnimate()
    }
    override func configCellAppear() {
        super.configCellAppear()
        self.backgroundColor = Color.clear
    }
}
