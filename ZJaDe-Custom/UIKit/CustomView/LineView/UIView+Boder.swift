//
//  UIView+Boder.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/10.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
enum BoderDirection:Int {
    case top = 15100
    case left = 15200
    case bottom = 15300
    case right = 15400
}
enum ExcludePoint:Int {
    case startPoint
    case endPoint
    case allPoint
}
extension UIView {
    /// ZJaDe: 添加top boder
    func addBorderTop(boderWidth:CGFloat = 1,color:UIColor = Color.boderLine,padding:CGFloat = 0,edgeType:ExcludePoint = .allPoint,autoLayout:Bool = true) {
        self.addBorder(boderWidth: boderWidth, direction: .top, color: color, padding: padding, edgeType: edgeType,autoLayout:autoLayout)
    }
    /// ZJaDe: 添加bottom boder
    func addBorderBottom(boderWidth:CGFloat = 1,color:UIColor = Color.boderLine,padding:CGFloat = 0,edgeType:ExcludePoint = .allPoint,autoLayout:Bool = true) {
        self.addBorder(boderWidth: boderWidth, direction: .bottom, color: color, padding: padding, edgeType: edgeType,autoLayout:autoLayout)
    }
    /// ZJaDe: 添加left boder
    func addBorderLeft(boderWidth:CGFloat = 1,color:UIColor = Color.boderLine,padding:CGFloat = 0,edgeType:ExcludePoint = .allPoint,autoLayout:Bool = true) {
        self.addBorder(boderWidth: boderWidth, direction: .left, color: color, padding: padding, edgeType: edgeType,autoLayout:autoLayout)
    }
    /// ZJaDe: 添加right boder
    func addBorderRight(boderWidth:CGFloat = 1,color:UIColor = Color.boderLine,padding:CGFloat = 0,edgeType:ExcludePoint = .allPoint,autoLayout:Bool = true) {
        self.addBorder(boderWidth: boderWidth, direction: .right, color: color, padding: padding, edgeType: edgeType,autoLayout:autoLayout)
    }
    //MARK: -
    /// ZJaDe: padding 为负时，表示固定宽度
    private func addBorder(boderWidth:CGFloat,direction:BoderDirection,color:UIColor,padding:CGFloat,edgeType:ExcludePoint,autoLayout:Bool) {
        let fixedLength:CGFloat? = padding < 0 ? -padding : nil
        let tag = direction.rawValue
        let lineAxis:LineAxis
        var boderLength:CGFloat
        switch direction {
        case .left,.right:
            lineAxis = .vertical
            boderLength = self.height
        case .top,.bottom:
            lineAxis = .horizontal
            boderLength = self.width
        }
        var border:LineView! = self.viewWithTag(tag) as? LineView
        guard boderWidth > 0 else {
            border?.removeFromSuperview()
            return
        }
        if border == nil {
            border = LineView.solidLine(lineAxis: lineAxis)
            border.isUserInteractionEnabled = false
            border.tag = tag
        }else {
            border.removeFromSuperview()
        }
        self.insertSubview(border, at: 0)
        border.lineColor = color
        border.translatesAutoresizingMaskIntoConstraints = !autoLayout
        /*************** layout ***************/
        var startPadding:CGFloat = 0
        var endPadding:CGFloat = 0
        if fixedLength == nil {
            switch edgeType {
            case .startPoint,.allPoint:
                startPadding += padding
                if edgeType == .allPoint {
                    fallthrough
                }
            case .endPoint:
                endPadding += padding
            }
        }
        if border.translatesAutoresizingMaskIntoConstraints {
            if fixedLength == nil {
                boderLength -= startPadding + endPadding
            }else {
                boderLength = fixedLength!
            }
            switch direction {
            case .top:
                border.frame = CGRect(x: startPadding, y: 0, width: boderLength, height: boderWidth)
            case .left:
                border.frame = CGRect(x: 0, y: startPadding, width: boderWidth, height: boderLength)
            case .bottom:
                border.frame = CGRect(x: startPadding, y: self.height - boderWidth, width: boderLength, height: boderWidth)
            case .right:
                border.frame = CGRect(x: self.width - boderWidth, y: startPadding, width: boderWidth, height: boderLength)
            }
        }else {
            func addBoderConstraint(attr attr1:NSLayoutAttribute, toItem:UIView?, attr attr2:NSLayoutAttribute, constant:CGFloat) {
                self.addConstraint(NSLayoutConstraint(item: border, attribute: attr1, relatedBy: .equal, toItem: toItem, attribute: attr2, multiplier: 1, constant: constant))
            }
            switch direction {
            case .top, .bottom:
                if fixedLength == nil {
                    addBoderConstraint(attr: .left, toItem: self, attr: .left, constant: startPadding)
                    addBoderConstraint(attr: .right, toItem: self, attr: .right, constant: -endPadding)
                }else {
                    addBoderConstraint(attr: .width, toItem: nil, attr: .notAnAttribute, constant: fixedLength!)
                    addBoderConstraint(attr: .centerX, toItem: self, attr: .centerX, constant: 0)
                }
                addBoderConstraint(attr: .height, toItem: nil, attr: .notAnAttribute, constant: boderWidth)
                if direction == .top {
                    addBoderConstraint(attr: .top, toItem: self, attr: .top, constant: 0)
                }else {
                    addBoderConstraint(attr: .bottom, toItem: self, attr: .bottom, constant: 0)
                }
            case .left, .right:
                if fixedLength == nil {
                    addBoderConstraint(attr: .top, toItem: self, attr: .top, constant: startPadding)
                    addBoderConstraint(attr: .bottom, toItem: self, attr: .bottom, constant: -endPadding)
                }else {
                    addBoderConstraint(attr: .height, toItem: nil, attr: .notAnAttribute, constant: fixedLength!)
                    addBoderConstraint(attr: .centerY, toItem: self, attr: .centerY, constant: 0)
                }
                addBoderConstraint(attr: .width, toItem: nil, attr: .notAnAttribute, constant: boderWidth)
                if direction == .left {
                    addBoderConstraint(attr: .left, toItem: self, attr: .left, constant: 0)
                }else {
                    addBoderConstraint(attr: .right, toItem: self, attr: .right, constant: 0)
                }
            }
        }
    }
}
