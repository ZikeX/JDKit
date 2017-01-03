//
//  ListModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
protocol ListModelStateProtocol {
    var enabled:Bool {get set}
    func canEnabled() -> Bool
    var isSelected:Bool {get set}
}
class ListModel:NSObject {
    lazy var cellClassName:String = {
        return jd.namespace + "." + self.cellName
    }()
    var viewNameSuffix:String {
        return "Cell"
    }
    lazy var cellName:String = {
        var cellName = self.classStr
        let range = Range(cellName.characters.index(cellName.endIndex, offsetBy: -5) ..<  cellName.endIndex)
        cellName.replaceSubrange(range, with: self.viewNameSuffix)
        return cellName
    }()
    lazy var reuseIdentifier:String = self.cellName
    
    /*************** init ***************/
    required override init() {
        super.init()
        configModelInit()
    }
    func configModelInit() {
        
    }
    // MARK: - UpdateModelProtocol
    var isHidden:Bool = false
    var needUpdate:Bool = false
    // MARK: - IdentifiableType
    var identity: Int {
        return self.hashValue
    }
    // MARK: - ListModelProtocol
    private(set) var enabledVariable:Variable<Bool> = Variable(true)
    var enabled:Bool {
        get {
            return enabledVariable.value
        }
        set {
            enabledVariable.value = newValue
        }
    }
    func canEnabled() -> Bool {
        return self.enabled
    }
    var key:String = ""
    var isSelected:Bool = false
    
    deinit {
        logDebug("\(type(of:self))->\(self)注销")
    }
}
extension ListModel:IdentifiableType {
    
}
extension ListModel:ListModelStateProtocol {
    
}
