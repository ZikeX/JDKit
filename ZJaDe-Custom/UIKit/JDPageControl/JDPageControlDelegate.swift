//
//  JDPageControlDelegate.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol JDPageControlDelegate:class {
    func createItem() -> PageItemView
    func layoutItem(itemView:PageItemView)
}
