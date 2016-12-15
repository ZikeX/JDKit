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
        guard let model = model as? JDSwitchModel else {
            return
        }
        model.isOn.asObservable().distinctUntilChanged().bindTo(switchView.rx.value).addDisposableTo(disposeBag)
        switchView.rx.value.distinctUntilChanged().bindTo(model.isOn).addDisposableTo(disposeBag)
        
        switchView.rx.valueChanged {[unowned model] (switchView) in
            model.valueChanged.onNext(switchView.isOn)
        }.addDisposableTo(disposeBag)
    }
    override func updateEnabledState(_ model: JDTableModel, enabled: Bool) {
        super.updateEnabledState(model, enabled: enabled)
        self.switchView.isEnabled = enabled
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
