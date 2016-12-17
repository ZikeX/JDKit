//
//  JDCollectionReusableView+CellProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/2.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//
import UIKit
import RxSwift

extension JDCollectionReusableView : CellProtocol {
    typealias ModelType = JDCollectionReusableModel
    
    // MARK: - view初始化
    func configItemInit() {
        
    }
    // MARK: - 做一些数据初始化
    func itemDidInit() {
        
    }
    // MARK: - view加载完毕，初始化数据及约束
    final func itemDidLoad(_ element: JDCollectionReusableModel) {
        self.configItem(element)
    }
    // MARK: - view将要显示，做动画，element绑定view
    final func itemWillAppear(_ element: JDCollectionReusableModel) {
        configItemWithElement(element)
        itemUpdateConstraints(element)
    }
    // MARK: view根据element绑定数据
    final func configItemWithElement(_ element: JDCollectionReusableModel) {
        self.bindingModel(element)
        // MARK: - 更新enabled状态
        element.enabledVariable.asObservable().subscribe(onNext:{[unowned self,unowned element] (enabled) in
            let enabled = element.canEnabled()
            self.enabled = enabled
            self.updateEnabledState(element, enabled: enabled)
        }).addDisposableTo(disposeBag)
    }
    // MARK: view设置数据后,如果需要在这里更新约束
    final func itemUpdateConstraints(_ element: JDCollectionReusableModel) {
        self.didBindingModel(element)
    }
    // MARK: - view已经消失,element解绑view
    final func itemDidDisappear(_ element: JDCollectionReusableModel?) {
        disposeBag = DisposeBag()
        
        self.unbindingModel(element)
    }
}
