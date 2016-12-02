//
//  JDTableCell+CellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

extension JDTableCell : CellProtocol {
    typealias ModelType = JDTableModel
    
    // MARK: - cell初始化
    func configItemInit() {
        
    }
    // MARK: - 做一些数据初始化
    func itemDidInit() {
        self.jdContentView.removeFromSuperview()
        self.contentView.addSubview(jdContentView)
        self.contentView.addSubview(separatorLineView)
    }
    // MARK: - cell加载完毕，初始化数据及约束
    final func itemDidLoad(_ element: JDTableModel) {
        self.updateLayout.deactivate()
        self.updateLayout.constraintArr += self.jdContentView.snp.prepareConstraints({ (maker) in
            maker.left.equalToSuperview().offset(element.spaceEdges.left)
            maker.right.equalToSuperview().offset(-element.spaceEdges.right)
            maker.top.equalToSuperview().offset(element.spaceEdges.top)
            maker.bottomSpace(self.separatorLineView).offset(-element.spaceEdges.bottom - element.separatorInset.top)
        })
        self.updateLayout.constraintArr += self.separatorLineView.snp.prepareConstraints({ (maker) in
            maker.height.equalTo(element.lineHeight)
            maker.bottom.equalToSuperview().offset(-element.separatorInset.bottom).priority(999)
            if element.separatorInsetLayoutToContentView {
                maker.left.equalToSuperview().offset(element.separatorInset.left)
                maker.right.equalToSuperview().offset(-element.separatorInset.right)
            }else {
                maker.left.equalTo(self).offset(-element.separatorInset.left)
                maker.right.equalTo(self).offset(element.separatorInset.right)
            }
        })
        self.updateLayout.activate()
        
        self.configItem(element)
        if let model = element as? JDCustomModel,
            let cell = self as? JDCustomCell {
            model.layoutCellClosure?(cell)
        }else if let model = element as? JDFormModel,
            let cell = self as? JDFormCell {
            model.layoutCellClosure?(cell)
        }
    }
    // MARK: - cell将要显示，做动画，element绑定cell
    final func itemWillAppear(_ element: JDTableModel) {
        self.cellAppearAnimate()
        self.configItemWithElement(element)
        self.itemUpdateConstraints(element)
    }
    // MARK: cell根据element绑定数据
    final func configItemWithElement(_ element: JDTableModel) {
        self.selectedBackgroundView = element.cellSelectedBackgroundView
        if let color = element.cellSelectedBackgroundColor {
            self.selectedBackgroundView?.backgroundColor = color
        }
        separatorLineView.backgroundColor = element.lineColor
        // MARK: - isSelected
        if element.isSelected {
            self.accessoryView = ImageView(image: R.image.ic_cell_checkmark())
        }else {
            self.accessoryView = nil
        }
        // MARK: - 绑定数据
        self.bindingModel(element)
        if let model = element as? JDCustomModel,
            let cell = self as? JDCustomCell {
            model.bindingCellClosure?(cell)
        }else if let model = element as? JDFormModel,
            let cell = self as? JDFormCell {
            model.bindingCellClosure?(cell)
        }
        // MARK: - 更新enabled状态
        element.enabledVariable.asObservable().subscribe(onNext:{[unowned self,unowned element] (enabled) in
            let enabled = element.canEnabled()
            self.enabled = enabled
            self.updateEnabledState(element, enabled: enabled)
            if let model = element as? JDCustomModel,
                let cell = self as? JDCustomCell {
                model.updateEnabledStateClosure?(cell,enabled)
            }else if let model = element as? JDFormModel,
                let cell = self as? JDFormCell {
                model.updateEnabledStateClosure?(cell,enabled)
            }
        }).addDisposableTo(disposeBag)
    }
    // MARK: - cell设置数据后,如果需要在这里更新约束
    final func itemUpdateConstraints(_ element: JDTableModel) {
        self.didBindingModel(element)
        self.setNeedsUpdateConstraints()
    }
    // MARK: - cell已经消失,element解绑cell
    final func itemDidDisappear(_ element: JDTableModel?) {
        disposeBag = DisposeBag()
        
        self.unbindingModel(element)
    }
}
