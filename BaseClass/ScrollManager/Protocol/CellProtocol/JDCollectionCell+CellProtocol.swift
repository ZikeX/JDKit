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
    func configItemInit() {
        
    }
    // MARK: - 做一些数据初始化
    func itemDidInit() {
        
    }
    // MARK: - cell加载完毕，初始化数据及约束
    final func itemDidLoad(_ element: JDCollectionModel) {
        self.configItem(element)
    }
    // MARK: - cell将要显示，做动画，element绑定cell
    final func itemWillAppear(_ element: JDCollectionModel) {
        configItemWithElement(element)
        itemUpdateConstraints(element)
    }
    // MARK: cell根据element绑定数据
    final func configItemWithElement(_ element: JDCollectionModel) {
        self.bindingModel(element)
        // MARK: - 更新enabled状态
        element.enabledVariable.asObservable().subscribe(onNext:{[unowned self,unowned element] (enabled) in
            let enabled = element.canEnabled()
            self.enabled = enabled
            self.updateEnabledState(element, enabled: enabled)
        }).addDisposableTo(disposeBag)
    }
    // MARK: cell设置数据后,如果需要在这里更新约束
    final func itemUpdateConstraints(_ element: JDCollectionModel) {
        self.didBindingModel(element)
    }
    // MARK: - cell已经消失,element解绑cell
    final func itemDidDisappear(_ element: JDCollectionModel?) {
        disposeBag = DisposeBag()
        
        self.unbindingModel(element)
    }
}
