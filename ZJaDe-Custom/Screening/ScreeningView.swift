//
//  ScreeningView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class ScreeningView: CustomIBView {
    var itemDataArr = [String]() {
        didSet {
            self.configItems()
        }
    }
    var itemArray = [Button]() {
        didSet {
            itemStackView.removeAllSubviews()
            itemArray.forEach { (item) in
                itemStackView.addArrangedSubview(item)
            }
        }
    }
    fileprivate let itemStackView = UIStackView(alignment: .fill, distribution: .fillEqually)
    // MARK: - selected
    var selectedItem:Button? {
        willSet {
            if let item = self.selectedItem {
                UIView.animate(withDuration: 0.25) {
                    item.img = nil
                    item.addBorderBottom()
                    item.setNeedsLayout()
                    item.layoutIfNeeded()
                }
            }
        }
        didSet {
            var index:Int?
            if let item = self.selectedItem {
                index = self.itemArray.index(of: item)
                UIView.animate(withDuration: 0.25) {
                    item.img = R.image.ic_下三角()
                    item.addBorderBottom(fixedLength:0)
                    item.setNeedsLayout()
                    item.layoutIfNeeded()
                }
            }
            self.updateItemsBoderRight(index)
            selectItemChangedClosure?(index,selectedItem)
        }
    }

    typealias ScreeningClosureType = (Int?,Button?)->()
    fileprivate(set) var selectItemChangedClosure:ScreeningClosureType?
    func configSelectItemChanged(_ closure:ScreeningClosureType?) {
        self.selectItemChangedClosure = closure
    }
    override func configInit() {
        super.configInit()
        self.backgroundColor = Color.white
        self.addSubview(self.itemStackView)
        itemStackView.edgesToView()
    }
}
extension ScreeningView {
    func configItems() {
        guard self.itemDataArr.count > 0 else {
            fatalError("item数量不能为0")
        }
        var itemArray = self.itemArray
        while itemArray.count != self.itemDataArr.count {
            if itemArray.count > self.itemDataArr.count {
                itemArray.removeLast()
            }else {
                let button = Button()
                button.textLabel.font = Font.h3
                button.textLabel.textColor = Color.black
                
                button.addBorderBottom()
                button.rx.touchUpInside({[unowned self] (item) in
                    if self.selectedItem != item {
                        self.selectedItem = item
                    }else {
                        self.clearSelectedItem()
                    }
                })
                itemArray.append(button)
            }
        }
        itemArray.enumerated().forEach { (index,button) in
            button.textStr = self.itemDataArr[index]
        }
        if itemArray.count != self.itemArray.count {
            self.itemArray = itemArray
            self.clearSelectedItem()
        }
    }
    func updateItemsBoderRight(_ selectIndex:Int?) {
        UIView.animate(withDuration: 0.25) {
            self.itemArray.enumerated().forEach { (offset: Int, element: Button) in
                if offset != self.itemArray.count - 1 {
                    if let index = selectIndex,(index == offset || index - 1 == offset) {
                        element.addBorderRight()
                    }else {
                        element.addBorderRight(padding:5)
                    }
                }else {
                    element.addBorderRight(boderWidth: 0)
                }
            }
        }
    }
    func clearSelectedItem() {
        if self.selectedItem != nil {
            self.selectedItem = nil
        }else {
            self.updateItemsBoderRight(nil)
        }
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: jd.screenWidth, height: 44)
    }
}
