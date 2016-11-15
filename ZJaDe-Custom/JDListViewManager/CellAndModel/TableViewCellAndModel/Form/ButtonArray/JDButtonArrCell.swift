//
//  JDButtonArrCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import Dollar

class JDButtonArrCell: JDFormCell {
    // MARK: - Category
    lazy var gridView:GridView<GridViewItemType> = self.createGridView()
    var gridViewItemsData = [GridViewItemDataType](){
        didSet {
            self.gridView.itemArray = getButtonArray(dataArray: gridViewItemsData)
        }
    }
    override func configCellInit() {
        super.configCellInit()
        jdContentView.addSubview(self.gridView)
        self.gridView.edgesToView()
    }
}
extension JDButtonArrCell {
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let model = model as? JDButtonArrModel else {
            return
        }
        model.dataArray.asObservable().subscribe { (event) in
            if let array = event.element {
                self.gridViewItemsData = array
            }
        }.addDisposableTo(disposeBag)
        self.gridView.itemArray.forEach { (button) in
            button.isSelected = model.selectedButtons.contains(button)
            model.buttonsSelectedAppearance(button)
            button.rx.tap.subscribe({ (_) in
                button.isSelected = !button.isSelected
                model.buttonsSelectedAppearance(button)
                self.checkMaxCount(model: model)
            }).addDisposableTo(disposeBag)
        }
    }
    private func checkMaxCount(model:JDButtonArrModel) {
        let maxSelectButtonCount = model.maxSelectButtonCount
        
        if maxSelectButtonCount > 0 && model.selectedButtons.count > maxSelectButtonCount {
            let button = model.selectedButtons.removeFirst()
            button.isSelected = false
            model.buttonsSelectedAppearance(button)
        }
    }
}
extension JDButtonArrCell:GridViewProtocol {
    typealias GridViewItemType = Button
    typealias GridViewItemDataType = (String?,UIImage?)
    func createGridView() -> GridView<GridViewItemType> {
        let itemsView = GridView<Button>()
        itemsView.columns = 4
        itemsView.gridEdges = UIEdgeInsetsMake(10, 0, 10, 0)
        itemsView.verticalSpace = 10
        itemsView.backgroundColor = Color.white
        return itemsView
    }
    func getButtonArray(dataArray:[GridViewItemDataType]) -> [GridViewItemType] {
        var array = [GridViewItemType]()
        
        for (title,image) in dataArray {
            let button = Button(title:title,image:image)
            button.textLabel.font = Font.h5
            button.titleAndImgLocation = .bottomToTop
            array.append(button)
        }
        return array
    }
}
