//
//  JDModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDModel: NSObject {
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
}
