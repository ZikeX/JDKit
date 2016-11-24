//
//  JDStaticModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDStaticModel: JDTableModel {
    var layoutCellClosure:JDCellCompatibleType?
    var bindingCellClosure:JDCellCompatibleType?
}
extension JDEntryModel {//DateTextField
    func createDateTextFieldCell() {
        let oldLayoutClosure = self.layoutCellClosure
        self.configLayoutCell {[unowned self] (cell) in
            oldLayoutClosure?(cell)
            guard let cell = cell as? JDEntryCell else {
                return
            }
            cell.stackView.snp.makeConstraints { (maker) in
                maker.top.centerY.equalToSuperview()
            }
            let stackView = cell.jdContentView.createIfNotExisting(tag: 100, { (contentView) -> UIView in
                return UIStackView(alignment: .fill, spacing: 8)
            }).makeLayoutView({ (stackView, maker) in
                maker.top.bottom.right.equalToSuperview()
                maker.leftSpace(cell.stackView)
            }) as! UIStackView
            let firstTextField = stackView.createIfNotExisting(tag: 1001, { (stackView) -> UIView in
                let firstTextField = ComposeTextField(color: Color.black, font: Font.h3)
                firstTextField.entryType = .date(mode:.date)
                firstTextField.textAlignment = .center
                return firstTextField
            }) as! ComposeTextField
            stackView.createIfNotExisting(tag: 1002, { (stackView) -> UIView in
                let label = UILabel(text: "至", color: Color.black, font: Font.h3)
                label.contentHuggingHorizontalPriority = UILayoutPriorityRequired
                return label
            })
            let secondTextField = stackView.createIfNotExisting(tag: 1003, { (stackView) -> UIView in
                let secondTextField = ComposeTextField(color: Color.black, font: Font.h3)
                secondTextField.entryType = .date(mode:.date)
                secondTextField.textAlignment = .center
                return secondTextField
            }).makeLayoutView({ (view, maker) in
                maker.width.equalTo(firstTextField)
            }) as! ComposeTextField
            cell.binding(textField: firstTextField, model: self, index: 0)
            cell.binding(textField: secondTextField, model: self, index: 1)
        }
    }
    // MARK: -
    func createFullReductionCell(buttonClickClosure:@escaping ((Button)->())) {
        self.configLayoutCell {[unowned self] (cell) in
            guard let cell = cell as? JDEntryCell else {
                return
            }
            let stackView = cell.jdContentView.createIfNotExisting(tag: 10, { (content) -> UIView in
                let stackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
                stackView.addBorderRight()
                return stackView
            }).makeLayoutView({ (stackView, maker) in
                maker.left.top.bottom.equalToSuperview()
            })
            let firstItem = stackView.createIfNotExisting(tag: 101, { (stackView) -> UIView in
                let item = TitleTextFieldItem()
                item.titleLabel.textColor = Color.gray
                item.titleLabel.widthValue(width: 50)
                item.titleLabel.textAlignment = .right
                item.textField.entryType = .price
                item.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
                item.addBorderBottom()
                return item
            }) as! TitleTextFieldItem
            let secondItem = stackView.createIfNotExisting(tag: 102, { (stackView) -> UIView in
                let item = TitleTextFieldItem()
                item.titleLabel.textColor = Color.gray
                item.titleLabel.widthValue(width: 50)
                item.titleLabel.textAlignment = .right
                item.textField.entryType = .price
                item.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5)
                return item
            })as! TitleTextFieldItem
            cell.jdContentView.createIfNotExisting(tag: 11, { (contentView) -> UIView in
                let button = Button(image: R.image.ic_cell_删除(), isTemplate: true)
                button.tintColor = Color.black
                return button
            }).makeLayoutView({ (view, maker) in
                maker.top.bottom.right.equalToSuperview()
                maker.height_width(scale: 2)
                maker.leftSpace(stackView)
            })
            cell.binding(titleTextField: firstItem, model: self, index: 0)
            cell.binding(titleTextField: secondItem, model: self, index: 1)
        }
        self.configBindingCell { (cell) in
            cell.jdContentView.addBorder()
            cell.jdContentView.cornerRadius = 5
            if let button = cell.jdContentView.viewWithTag(11) as? Button {
                button.rx.touchUpInside({ (button) in
                    buttonClickClosure(button)
                }).addDisposableTo(cell.disposeBag)                
            }
        }
    }
    func createDateTimeCell() {
        let oldLayoutClosure = self.layoutCellClosure
        self.configLayoutCell {[unowned self] (cell) in
            oldLayoutClosure?(cell)
            guard let cell = cell as? JDEntryCell else {
                return
            }
            cell.stackView.snp.makeConstraints { (maker) in
                maker.top.centerY.equalToSuperview()
            }
            let stackView = cell.jdContentView.createIfNotExisting(tag: 100, { (contentView) -> UIView in
                return UIStackView(alignment: .fill, spacing: 8)
            }).makeLayoutView({ (stackView, maker) in
                maker.top.bottom.right.equalToSuperview()
                maker.leftSpace(cell.stackView)
            }) as! UIStackView
            let firstItem = stackView.createIfNotExisting(tag: 101, { (stackView) -> UIView in
                let item = TitleTextFieldItem()
                item.titleLabel.textColor = Color.gray
                item.titleLabel.textAlignment = .right
                item.textField.entryType = .date(mode:.date)
                item.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
                item.addBorderBottom()
                return item
            }) as! TitleTextFieldItem
            let secondItem = stackView.createIfNotExisting(tag: 102, { (stackView) -> UIView in
                let item = TitleTextFieldItem()
                item.titleLabel.textColor = Color.gray
                item.titleLabel.textAlignment = .right
                item.textField.entryType = .date(mode:.time)
                item.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 5)
                return item
            }).makeLayoutView({ (view, maker) in
                maker.width.equalTo(firstItem)
            }) as! TitleTextFieldItem
            cell.binding(titleTextField: firstItem, model: self, index: 0)
            cell.binding(titleTextField: secondItem, model: self, index: 1)
        }
    }
}
