//
//  JDButtonArrCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import Dollar

class JDButtonArrCell: JDFormCell {
    var buttonArr = [Button]() {
        didSet {
            buttonArr.enumerated().forEach { (offset: Int, element: Button) in
                element.tag = buttonTag(offset)
            }
        }
    }
    
    override func configCellInit() {
        super.configCellInit()
    }
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        guard let buttonArrModel = element as? JDButtonArrModel else {
            return
        }
        jdContentView.addSubview(buttonArrModel.stackView)
        buttonArrModel.stackView.edgesToView()
        
        if buttonArrModel.maxColumn > 0 {
            var count = buttonArrModel.dataArray.value.count
            let remainder = count % buttonArrModel.maxColumn
            count -= remainder
            count = remainder > 0 ? count + buttonArrModel.maxColumn : count
            buttonArr.countIsEqual(count) { Button() }
            
            let buttonTwoArr = $.chunk(buttonArr, size: buttonArrModel.maxColumn)
            buttonTwoArr.forEach({ (buttonArr) in
                let lineStackView = UIStackView(arrangedSubviews: buttonArr)
                lineStackView.distribution = .fillEqually
                buttonArrModel.stackView.addArrangedSubview(lineStackView)
                buttonArr.forEach({ (button) in
                    button.width_height(scale: buttonArrModel.sizeScale)
                })
            })
        }else {
            buttonArr.countIsEqual(buttonArrModel.dataArray.value.count) { Button() }
            
        }
    }
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let buttonArrModel = element as? JDButtonArrModel else {
            return
        }
        buttonArrModel.dataArray.asObservable().subscribe { (event) in
            if let array = event.element {
                self.buttonArr.enumerated().forEach({ (offset: Int, button: Button) in
                    if offset < array.count {
                        button.textStr = array[offset].0
                        button.img = array[offset].1
                        button.isSelected = buttonArrModel.selectedButtonIndexs.contains(offset)
                        buttonArrModel.buttonsSelectedAppearance(button,offset,button.isSelected)
                        button.isUserInteractionEnabled = true
                    }else {
                        button.textStr = nil
                        button.img = nil
                        button.isUserInteractionEnabled = false
                    }
                })
            }
        }.addDisposableTo(disposeBag)
        
        buttonArr.forEach { (button) in
            button.rx.tap.subscribe({ (event) in
                let buttonIndex = self.buttonIndex(button.tag)
                button.isSelected = !button.isSelected
                
                if button.isSelected && !buttonArrModel.selectedButtonIndexs.contains(buttonIndex) {
                    buttonArrModel.selectedButtonIndexs.append(buttonIndex)
                }else if !button.isSelected,let _index = buttonArrModel.selectedButtonIndexs.index(of: buttonIndex) {
                    buttonArrModel.selectedButtonIndexs.remove(at: _index)
                }
                self.checkMaxCount(buttonArrModel: buttonArrModel)
                buttonArrModel.buttonsSelectedAppearance(button,buttonIndex,button.isSelected)
            }).addDisposableTo(disposeBag)
        }
    }
    func checkMaxCount(buttonArrModel:JDButtonArrModel) {
        let maxSelectButtonCount = buttonArrModel.maxSelectButtonCount

        if maxSelectButtonCount > 0 && buttonArrModel.selectedButtonIndexs.count > maxSelectButtonCount {
            let buttonIndex = buttonArrModel.selectedButtonIndexs.removeFirst()
            let button = buttonArr[buttonIndex]
            button.isSelected = false
            buttonArrModel.buttonsSelectedAppearance(button,buttonIndex,button.isSelected)
        }
    }
}
extension JDButtonArrCell {
    func buttonTag(_ index:Int) -> Int {
        return index + 100
    }
    func buttonIndex(_ tag:Int) -> Int {
        return tag - 100
    }
}
