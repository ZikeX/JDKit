//
//  JDCustomModel.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDCustomModel: JDStaticModel {
    
    var layoutCellClosure:JDCellCompatibleType?
    var bindingCellClosure:JDCellCompatibleType?
    var updateEnabledStateClosure:JDUpdateEnabledStateType?
}
