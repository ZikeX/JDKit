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
    
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = button
        jdContentView.addSubview(button)
    }
}
extension JDButtonCell {
    override func configItem(_ model: TableModel) {
        super.configItem(model)
        guard let model = model as? JDButtonModel else {
            return
        }
        stackView.removeFromSuperview()
        button.edgesToView()
        self.touchCell = {[unowned model] in
            model.buttonClick.onNext()
        }
    }
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDButtonModel else {
            return
        }
        self.configButton(button)
        model.title.asObservable().subscribe(onNext:{[unowned self] (title) in
            self.button.textStr = title
        }).addDisposableTo(disposeBag)
        
        model.image.asObservable().subscribe(onNext:{[unowned self] (image) in
            self.button.img = image
        }).addDisposableTo(disposeBag)
        
        button.rx.tap.bindTo(model.buttonClick).addDisposableTo(disposeBag)
    }
    override func updateEnabledState(_ model: TableModel, enabled: Bool) {
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
    }
    override func configCell() {
        super.configCell()
        self.backgroundColor = Color.clear
    }
}
