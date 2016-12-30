//
//  JDButtonArrCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDButtonArrCell: JDFormCell {
    // MARK: - Category
    lazy var gridView:GridView<GridViewItemType> = self.createGridView()
    var gridViewItemsData = [GridViewItemDataType](){
        didSet {
            self.gridView.itemArray = getButtonArray(dataArray: gridViewItemsData)
        }
    }
    override func configItemInit() {
        super.configItemInit()
        jdContentView.addSubview(self.gridView)
        self.gridView.edgesToView()
    }
}
extension JDButtonArrCell {
    override func bindingModel(_ model: TableModel) {
        super.bindingModel(model)
        guard let model = model as? JDButtonArrModel else {
            return
        }
        model.dataArray.asObservable().subscribe(onNext: {[unowned self] (array) in
            self.gridViewItemsData = array
        }).addDisposableTo(disposeBag)
        
        self.gridView.itemArray.forEach { (button) in
            button.isSelected = model.selectedButtons.contains(button)
            model.buttonsSelectedAppearance(button)
            
            button.rx.touchUpInside({[unowned self] (button) in
                button.isSelected = !button.isSelected
                if button.isSelected && !model.selectedButtons.contains(button) {
                    model.selectedButtons.append(button)
                }else if !button.isSelected, let index = model.selectedButtons.index(of: button) {
                    model.selectedButtons.remove(at: index)
                }
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
        itemsView.gridEdges = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
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
