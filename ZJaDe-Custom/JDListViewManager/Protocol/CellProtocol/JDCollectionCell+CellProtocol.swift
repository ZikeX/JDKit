//
//  JDCollectionCell+CellProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

extension JDCollectionCell : CellProtocol {
    typealias ModelType = JDCollectionModel
    
    // MARK: - cell初始化
    func configCellInit() {
        
    }
    // MARK: - 做一些数据初始化
    func cellDidInit() {
        
    }
    // MARK: - cell加载完毕，初始化数据及约束
    final func cellDidLoad(_ element: JDCollectionModel) {
        self.configCell(element)
    }
    // MARK: - cell将要显示，做动画，element绑定cell
    final func cellWillAppear(_ element: JDCollectionModel) {
        configCellWithElement(element)
        cellUpdateConstraints(element)
    }
    // MARK: cell根据element绑定数据
    final func configCellWithElement(_ element: JDCollectionModel) {
        self.bindingModel(element)
    }
    // MARK: cell设置数据后,如果需要在这里更新约束
    final func cellUpdateConstraints(_ element: JDCollectionModel) {
        self.didBindingModel(element)
    }
    // MARK: - cell已经消失,element解绑cell
    final func cellDidDisappear(_ element: JDCollectionModel?) {
        disposeBag = DisposeBag()
        
        self.unbindingModel(element)
    }
}
