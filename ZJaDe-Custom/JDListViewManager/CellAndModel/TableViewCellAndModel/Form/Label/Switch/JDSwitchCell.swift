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
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let switchModel = element as? JDSwitchModel else {
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
