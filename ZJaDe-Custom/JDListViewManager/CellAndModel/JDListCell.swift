//
//  JDListCell.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

protocol JDListCell:CellProtocol {
    var disposeBag:DisposeBag {get set}
}
extension JDTableCell:JDListCell {
    
}
extension JDCollectionCell:JDListCell {
    
}
