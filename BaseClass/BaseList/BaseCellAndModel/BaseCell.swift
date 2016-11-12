//
//  BaseCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseCell: JDCustomCell {
    final  override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        guard let model = element as? BaseModel else {
            return
        }
        self.configAndLayoutCell(model)
    }
    final override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let model = element as? BaseModel else {
            return
        }
        self.bindingModel(model)
    }
    final override func cellDidDisappear(_ element: JDTableViewModel) {
        super.cellDidDisappear(element)
        guard let model = element as? BaseModel else {
            return
        }
        self.unbindingModel(model)
    }
    // MARK: -
    func configAndLayoutCell(_ model: BaseModel) {
        
    }
    func bindingModel(_ model: BaseModel) {
        
    }
    func unbindingModel(_ model: BaseModel) {
        
    }
    // MARK: - touchCell
    var touchCell:(()->())?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            touchCell?()
        }
    }
}



