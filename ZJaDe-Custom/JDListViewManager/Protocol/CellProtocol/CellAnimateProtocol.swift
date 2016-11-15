//
//  CellAnimateProtocol.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

enum CellAppearAnimatedStyle {
    case outwardFromCenter //从中心往外放大
    case fromInsideOut //从内而外显示，同时透明度从0到1
    case custom //自定义
    case none //无动画
}
enum CellHighlightAnimatedStyle {
    case touchZoomOut //按下缩小，抬起来还原
    case shadow //阴影
    case custom //自定义
    case none //无动画
}
protocol CellAnimateProtocol {
    var appearAnimatedStyle:CellAppearAnimatedStyle {get set}
    var highlightAnimatedStyle:CellHighlightAnimatedStyle {get set}
    var selectedAnimated:Bool {get set}
    var animatedDuration:TimeInterval {get set}
    // MARK: - cellAppearAnimate
    func cellAppearAnimate()
    // MARK: - 自定义动画
    func customAppearAnimate(_ animatedDuration:TimeInterval)
}
extension CellAnimateProtocol where Self:UIView {
    func cellAppearAnimate() {
        switch appearAnimatedStyle {
        case .outwardFromCenter:
            self.outwardFromCenter(self.animatedDuration)
        case .fromInsideOut:
            self.fromInsideOut(self.animatedDuration)
        case .custom:
            self.customAppearAnimate(self.animatedDuration)
            break
        case .none:
            break
        }
    }
    func customAppearAnimate(_ animatedDuration:TimeInterval) {
        
    }
    
}

extension JDTableCell:CellAnimateProtocol {
    override func setSelected(_ selected: Bool, animated: Bool) {
        if self.selectedAnimated {
            super.setSelected(selected, animated: animated)
        }
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        switch highlightAnimatedStyle {
        case .touchZoomOut:
            super.setHighlighted(highlighted, animated: animated)
            self.touchZoomOut(self.animatedDuration, highlighted)
        case .shadow:
            super.setHighlighted(highlighted, animated: animated)
            self.shadow(self.animatedDuration, isHighlighted: highlighted,animated:animated)
        case .custom:
            super.setHighlighted(highlighted, animated: animated)
        case .none:
            break
        }
    }
}
