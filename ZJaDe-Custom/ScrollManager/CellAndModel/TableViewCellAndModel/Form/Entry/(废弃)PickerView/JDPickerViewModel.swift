//
//  JDPickerViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDPickerViewModel: JDTextFieldModel {
    
    var rowHeight:CGFloat = 44
    
    var _width:CGFloat?
    var defaultWidth:CGFloat {
        get {
            if _width == nil {
                return UIScreen.main.bounds.size.width / CGFloat(components.count)
            }
            return _width!
        }
        set {
            _width = newValue
        }
    }
    var components = [JDPickerViewComponentModel]() {
        didSet {
            for index in 0..<components.count {
                selectComponentsAndRows[index] = 0
            }
        }
    }
    var dataSource = JDPickerViewModelDataSource()
    
    var selectComponentsAndRows = [Int:Int]()
}
class JDPickerViewModelDataSource:NSObject,UIPickerViewDelegate,UIPickerViewDataSource {
    weak var pickViewModel:JDPickerViewModel!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickViewModel.components.count
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickViewModel.components[component].attStrArr.count
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickViewModel.rowHeight
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component < pickViewModel.components.count {
            let width = pickViewModel.components[component].width
            if width <= 0 {
                return pickViewModel.defaultWidth
            }
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let componentModel = pickViewModel.components[component]
        if component < pickViewModel.components.count && row < componentModel.attStrArr.count {
            return componentModel.attStrArr[row]
        }
        return nil
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickViewModel.selectComponentsAndRows[component] = row
    }
}
