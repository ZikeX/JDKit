//
//  JDSwitchCell.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDSwitchCell: JDLabelCell {
    var switchView = UISwitch()
    
    override func configCellInit() {
        super.configCellInit()
        self.jdFocusView = switchView
        self.accessoryView = switchView
        selectedAnimated = true
    }
}
extension JDSwitchCell {
    override func bindingModel(_ model: JDTableViewModel) {
        super.bindingModel(model)
        guard let switchModel = model as? JDSwitchModel else {
            return
        }
        switchModel.switchAppearanceClosure?(switchView)
        switchModel.isOn.asObservable().bindTo(switchView.rx.value).addDisposableTo(disposeBag)
        switchView.rx.value.bindTo(switchModel.isOn).addDisposableTo(disposeBag)
    }
}
extension JDSwitchCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            switchView.setOn(!switchView.isOn, animated: true)
        }
    }
}
