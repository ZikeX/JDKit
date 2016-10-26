//
//  GridView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/26.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class GridView<ItemType:UIView>: UIView {
    /// ZJaDe:columns 总列数
    var columns:Int = 0 {
        didSet {
            configItemsArray()
        }
    }
    /// ZJaDe: 总行数
    var lineTotalNum:Int {
        return (itemArray.count-1) / columns + 1
    }
    /// ZJaDe: item数组
    var itemArray = [ItemType]() {
        didSet {
            configItemsArray()
        }
    }
    var gridEdges = UIEdgeInsets() {
        didSet {
            updateSectionLayout()
        }
    }
    var horizontalSpace:CGFloat = 0 {
        didSet {
            configItemsArray()
        }
    }
    var verticalSpace:CGFloat = 0 {
        didSet {
            self.sectionsStackView.spacing = self.verticalSpace
        }
    }
    // MARK: -
    lazy fileprivate var sectionsStackView:UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 0)
        return stackView
    }()
    lazy fileprivate var itemsStackViews = [UIStackView]()
    lazy var placeholderView:UIView = {
        let view = UIView()
        return view
    }()
    // MARK: - init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.addSubview(sectionsStackView)
        updateSectionLayout()
    }
    
}
extension GridView {
    /// ZJaDe: 更新edge边距
    func updateSectionLayout() {
        sectionsStackView.snp.updateConstraints { (maker) in
            maker.edges.equalToSuperview().inset(gridEdges)
        }
    }
    /// ZJaDe: 核心布局方法
    func configItemsArray() {
        guard columns > 1 else {
            logError("总列数必须大于1")
            return
        }
        guard itemArray.count > 0 else {
            logError("itemArray数量不能小于0")
            return
        }
        itemsStackViews.forEach{$0.removeAllSubviews()}
        let lineTotalNum = self.lineTotalNum
        if lineTotalNum != itemsStackViews.count {
            itemsStackViews = [UIStackView]()
            itemsStackViews.countIsEqual(lineTotalNum) {return UIStackView()}
            
            sectionsStackView.removeAllSubviews()
            itemsStackViews.forEach({ (stackView) in
                sectionsStackView.addArrangedSubview(stackView)
                stackView.alignment = .fill
                stackView.spacing = self.horizontalSpace
            })
        }
        itemArray.enumerated().forEach { (offset: Int, element: ItemType) in
            /// ZJaDe: 在每一行的位置
            let lineNo = offset / columns
            let itemStackView = itemsStackViews[lineNo]
            
            itemStackView.addArrangedSubview(element)
            let _columns = columns.toCGFloat
            let offset = itemStackView.spacing * (_columns - 1) / _columns
            element.snp.makeConstraints({ (maker) in
                maker.width.equalTo(itemStackView).dividedBy(columns).offset(-offset)
            })
        }
        if let lastStackView = itemsStackViews.last,lastStackView.arrangedSubviews.count < columns {
            lastStackView.addArrangedSubview(placeholderView)
        }
    }
}
