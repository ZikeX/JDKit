//
//  NetworkVCProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/4.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import Foundation

protocol NetworkVCProtocol:AssociatedObjectProtocol {
    func setNeedToRequest()
    func setNeedUpdateData()
    
    func updateDataIfNeed()
    
    func request(refresh: Bool)
    func updateData()
}
private var isNeedUpdateDataKey:UInt8 = 0
private var isNeedToRequestKey:UInt8 = 0
extension NetworkVCProtocol where Self:BaseViewController {
    // MARK: - updateData
    private var isNeedUpdateData:Bool {
        get {return associatedObject(&isNeedUpdateDataKey) ?? false}
        set {setAssociatedObject(&isNeedUpdateDataKey, newValue)}
    }
    private var isNeedToRequest:Bool {
        get {return associatedObject(&isNeedToRequestKey) ?? false}
        set {setAssociatedObject(&isNeedToRequestKey, newValue)}
    }
    func setNeedToRequest() {
        isNeedToRequest = true
        if self.viewState == .viewDidAppear {
            updateDataIfNeed()
        }
    }
    func setNeedUpdateData() {
        isNeedUpdateData = true
        if self.viewState == .viewDidAppear {
            updateDataIfNeed()
        }
    }
    func updateDataIfNeed() {
        if self.isNeedToRequest {
            self.isNeedToRequest = false
            self.request()
        }
        if self.isNeedUpdateData {
            self.isNeedUpdateData = false
            self.updateData()
        }
    }
}
extension BaseViewController:NetworkVCProtocol {
    /// ZJaDe: need override
    func request(refresh: Bool = true) {
        updateData()
    }
    func updateData() {
        fatalError("子类实现相关逻辑")
    }
}
