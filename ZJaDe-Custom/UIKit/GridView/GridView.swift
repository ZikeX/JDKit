//
//  GridView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/26.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class GridView<ItemType:UIView>: UIView {
    /// ZJaDe:columns 总列数
    var columns:Int = 0 {
        didSet {
            if visiableItemArray.count > 0 {
                configItemsArray()
            }
        }
    }
    /// ZJaDe: 总行数
    var lineTotalNum:Int {
        return (visiableItemArray.count-1) / columns + 1
    }
    /// ZJaDe: item数组
    var itemArray = [ItemType]() {
        didSet {
            configItemsArray()
        }
    }
    var visiableItemArray:[ItemType] {
        return self.itemArray.filter({ (item) -> Bool in
            return !item.isHidden
        })
    }
    var gridEdges = UIEdgeInsets() {
        didSet {
            updateSectionLayout()
        }
    }
    var horizontalSpace:CGFloat = 0 {
        didSet {
            itemsStackViews.forEach({ (stackView) in
                stackView.spacing = self.horizontalSpace
            })
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
    func setNeedUpdateItems() {
        self.configItemsArray()
    }
    /// ZJaDe: 核心布局方法
    func configItemsArray() {
        guard columns > 0 else {
            logError("总列数必须大于0")
            return
        }
        guard visiableItemArray.count > 0 else {
            logError("visiableItemArray数量不能小于0")
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
        visiableItemArray.enumerated().forEach { (offset: Int, element: ItemType) in
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
