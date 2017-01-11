//
//  SelectBoxCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/11.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit

class SelectBoxCell: JDFormCell {
    
    lazy var dataStackView:UIStackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
    lazy var buttonArray = [Button]()
    
    override func configItemInit() {
        super.configItemInit()
        jdContentView.addSubview(dataStackView)
        dataStackView.snp.makeConstraints { (maker) in
            maker.edges.equalToSuperview()
            maker.height.equalTo(0)
        }
    }
}
extension SelectBoxCell {
    override func configItem(_ model: TableModel) {
        super.configItem(model)
        guard let model = model as? SelectBoxModel else {
            return
        }
        let itemCount = model.titleArray.count
        buttonArray.countIsEqual(itemCount){
            let button = Button()
            button.textLabel.font = Font.h3
            button.contentHorizontalAlignment = .left
            return button
        }
        dataStackView.removeAllSubviews()
        for button in buttonArray {
            dataStackView.addArrangedSubview(button)
        }
    }
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? SelectBoxModel else {
            return
        }
        buttonArray.enumerated().forEach { (offset,button) in
            button.textStr = model.titleArray[offset]
            button.isSelected = model.selectedButtonIndex == offset
            button.rx.touchUpInside({[unowned self] (button) in
                if offset != model.selectedButtonIndex {
                    if let oldIndex = model.selectedButtonIndex {
                        self.buttonArray[oldIndex].isSelected = false
                        self.buttonArray[oldIndex].tintColor = Color.black
                    }
                    button.isSelected = true
                    button.tintColor = Color.tintColor
                    model.selectedButtonIndex = offset
                }
            }).addDisposableTo(disposeBag)
        }
        let isShowBox = model.isShowBox.value
        model.lineHeight = isShowBox ? 1 : 0
        self.updateDataStackView(show: isShowBox)
        model.isShowBox.asObservable().skip(1).subscribe(onNext:{[unowned self] (isShowBox) in
            model.lineHeight = isShowBox ? 1 : 0
            self.updateCell(model, {
                self.updateDataStackView(show: isShowBox)
            })
        }).addDisposableTo(disposeBag)
    }
    func updateDataStackView(show:Bool) {
        let itemCount = dataStackView.arrangedSubviews.count
        dataStackView.snp.updateConstraints { (maker) in
            if show {
                maker.height.equalTo(itemCount * 44)
            }else {
                maker.height.equalTo(0)
            }
        }
    }
}
