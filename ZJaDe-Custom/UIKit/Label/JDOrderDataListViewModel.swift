//
//  JDOrderDataListViewModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class JDOrderDataListViewModel: BaseTableViewModel {
    lazy var monthLabel:UILabel = {
        let label = UILabel(text: "?月", color: Color.black, font: Font.h1)
        label.tag = 3
        label.cornerRadius = 22
        label.clipsToBounds = true
        label.textAlignment = .center
        label.backgroundColor = Color.viewBackground
        return label
    }()
    lazy var section:JDTableSection = {
        let section = JDTableSection()
        section.headerView!.backgroundColor = Color.white
        section.headerView!.thenMain({ (headerView) in
            let lineView = LineView()
            lineView.lineColor = Color.viewBackground
            headerView.addSubview(lineView)
            lineView.makeLayoutView({ (_, maker) in
                maker.top.equalTo(headerView.snp.centerY)
                maker.bottom.equalToSuperview()
                maker.width.equalTo(2)
                maker.centerX.equalTo(headerView.snp.left).offset(72)
            })
            headerView.addSubview(self.monthLabel)
            self.monthLabel.makeLayoutView({ (_, maker) in
                maker.centerY.equalToSuperview()
                maker.top.equalToSuperview().offset(10)
                maker.width_height(scale: 1)
                maker.centerX.equalTo(headerView.snp.left).offset(72)
            })
        })
        section.headerViewHeight = 64
        return section
    }()
    override func getLocalSectionModels() -> [(JDTableSection,[JDTableModel])]? {
        
        var models = [OrderDataModel]()
        for index in 0..<20 {
            let model = OrderDataModel()
            model.day = 28 - index
            model.orderCount = Int.random()
            models.append(model)
        }
        if models.count > 0 {
            let max = models.map { (model) -> Int in
                return model.orderCount ?? 0
                }.max()!
            models.forEach { (model) in
                model.maxOrderCount = max
            }
        }
        return [(self.section,models)]
    }
}
