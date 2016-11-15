//
//  JDTableCell+CellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

extension JDTableCell : CellProtocol {
    typealias ModelType = JDTableModel
    
    // MARK: - cell初始化
    func configCellInit() {
        
    }
    // MARK: - 做一些数据初始化
    func cellDidInit() {
        self.jdContentView.removeFromSuperview()
        self.contentView.addSubview(jdContentView)
        self.contentView.addSubview(separatorLineView)
    }
    // MARK: - cell加载完毕，初始化数据及约束
    final func cellDidLoad(_ element: JDTableModel) {
        self.updateLayout.deactivate()
        self.updateLayout.constraintArr += self.jdContentView.snp.prepareConstraints({ (maker) in
            maker.left.equalToSuperview().offset(element.spaceEdges.left)
            maker.right.equalToSuperview().offset(-element.spaceEdges.right)
            maker.top.equalToSuperview().offset(element.spaceEdges.top)
            maker.bottomSpace(self.separatorLineView).offset(-element.spaceEdges.bottom - element.separatorInset.top)
        })
        self.updateLayout.constraintArr += self.separatorLineView.snp.prepareConstraints({ (maker) in
            maker.height.equalTo(element.lineHeight)
            maker.bottom.equalToSuperview().offset(-element.separatorInset.bottom)
            if element.separatorInset.left > 0 {
                maker.left.equalToSuperview().offset(element.separatorInset.left)
            }else {
                maker.left.equalTo(self).offset(-element.separatorInset.left)
            }
            if element.separatorInset.right > 0 {
                maker.right.equalToSuperview().offset(-element.separatorInset.right)
            }else {
                maker.right.equalTo(self).offset(element.separatorInset.right)
            }
        })
        self.updateLayout.activate()
        
        self.configCell(element)
        if let model = element as? JDFormModel,
            let cell = self as? JDFormCell {
            model.layoutCellClosure?(cell)
        }
    }
    // MARK: - cell将要显示，做动画，element绑定cell
    final func cellWillAppear(_ element: JDTableModel) {
        self.cellAppearAnimate()
        self.configCellWithElement(element)
        self.cellUpdateConstraints(element)
    }
    // MARK: cell根据element绑定数据
    final func configCellWithElement(_ element: JDTableModel) {
        self.selectedBackgroundView = element.cellSelectedBackgroundView
        if let color = element.cellSelectedBackgroundColor {
            self.selectedBackgroundView?.backgroundColor = color
        }
        separatorLineView.backgroundColor = element.lineColor
        
        self.bindingModel(element)
        if let model = element as? JDFormModel,
            let cell = self as? JDFormCell {
            model.bindingCellClosure?(cell)
        }
    }
    // MARK: cell设置数据后,如果需要在这里更新约束
    final func cellUpdateConstraints(_ element: JDTableModel) {
        self.didBindingModel(element)
        self.setNeedsUpdateConstraints()
    }
    // MARK: - cell已经消失,element解绑cell
    final func cellDidDisappear(_ element: JDTableModel) {
        disposeBag = DisposeBag()
        
        self.unbindingModel(element)
    }
}
