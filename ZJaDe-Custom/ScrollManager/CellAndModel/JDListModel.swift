//
//  JDListModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
protocol ListModelStateProtocol {
    var key:String? {get set}
    var enabled:Bool? {get set}
    func canEnabled() -> Bool
    var isSelected:Bool {get set}
}
class JDListModel:NSObject {
    lazy var cellClassName:String = {
        return jd.namespace + "." + self.cellName
    }()
    lazy var cellName:String = {
        var cellName = self.classStr
        let range = Range(cellName.characters.index(cellName.endIndex, offsetBy: -5) ..<  cellName.endIndex)
        cellName.replaceSubrange(range, with: "Cell")
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
    private(set) var enabledVariable:Variable<Bool?> = Variable(nil)
    var enabled:Bool? {
        get {
            return enabledVariable.value
        }
        set {
            enabledVariable.value = newValue
        }
    }
    func canEnabled() -> Bool {
        return self.enabled ?? true
    }
    var key:String?
    var isSelected:Bool = false
}
extension JDListModel:IdentifiableType {
    
}
extension JDListModel:ListModelStateProtocol {
    
}
