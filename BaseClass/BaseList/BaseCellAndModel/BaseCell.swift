//
//  BaseCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class BaseCell: JDTableCell {
    // MARK: - touchCell
    var touchCell:(()->())?
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            touchCell?()
        }
    }
}



