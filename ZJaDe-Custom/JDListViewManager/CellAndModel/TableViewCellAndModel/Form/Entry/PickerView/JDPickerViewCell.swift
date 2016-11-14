//
//  JDPickerViewCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit


class JDPickerViewCell: JDTextFieldCell {
    var pickerView = UIPickerView()
    override func configCellInit() {
        super.configCellInit()
    }
}
extension JDPickerViewCell {
    override func bindingModel(_ model: JDTableViewModel) {
        super.bindingModel(model)
        guard let pickerViewModel = model as? JDPickerViewModel else {
            return
        }
        if pickerViewModel.components.count > 0 && pickerViewModel.components.first!.attStrArr.count > 0 {
            textField.inputView = self.pickerView
            pickerView.delegate = pickerViewModel.dataSource
            pickerView.dataSource = pickerViewModel.dataSource
        }
        pickerViewModel.pickerViewAppearanceClosure?(pickerView)
        textField.rx.controlEvent(.editingDidBegin).subscribe { (event) in
            pickerViewModel.selectComponentsAndRows.forEach { (component, row) in
                self.pickerView.selectRow(row, inComponent: component, animated: false)
            }
            self.setTextFieldText(pickerViewModel)
        }.addDisposableTo(disposeBag)
        self.pickerView.rx.itemSelected.subscribe { (event) in
            self.setTextFieldText(pickerViewModel)
        }.addDisposableTo(disposeBag)
    }
}

extension JDPickerViewCell {
    func setTextFieldText(_ pickerViewModel:JDPickerViewModel) {
        textField.text = ""
        pickerViewModel.selectComponentsAndRows.forEach({ (component, row) in
            let rowStr = pickerViewModel.components[component].attStrArr[row].string
            textField.text! += "\(rowStr), "
        })
        let endIndex = textField.text!.characters.endIndex
        let beginIndex = textField.text!.characters.index(endIndex, offsetBy: -2)
        textField.text!.replaceSubrange(beginIndex..<endIndex, with: "")
    }
}
