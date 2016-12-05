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
    
    override func configItemInit() {
        super.configItemInit()
        self.jdFocusView = switchView
        self.accessoryView = switchView
    }
}
extension JDSwitchCell {
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let switchModel = model as? JDSwitchModel else {
            return
        }
        switchModel.valueChanged.distinctUntilChanged().bindTo(switchView.rx.value).addDisposableTo(disposeBag)
        switchView.rx.value.distinctUntilChanged().bindTo(switchModel.valueChanged).addDisposableTo(disposeBag)
    }
    override func updateEnabledState(_ model: JDTableModel, enabled: Bool) {
        super.updateEnabledState(model, enabled: enabled)
        self.switchView.isEnabled = enabled
    }
    override func updateSelectedState(_ selected: Bool) {
        self.accessoryView = self.switchView
    }
}
extension JDSwitchCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            switchView.setOn(!switchView.isOn, animated: true)
            switchView.sendActions(for: .valueChanged)
        }
    }
}
