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
    private func addBorder(boderWidth:CGFloat,direction:BoderDirection,color:UIColor,padding:CGFloat,edgeType:ExcludePoint,autoLayout:Bool) {
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
        if border == nil {
            border = LineView.solidLine(lineAxis: lineAxis)
            border.isUserInteractionEnabled = false
            border.tag = tag
            self.insertSubview(border, at: 0)
        }
        border.lineColor = color
        border.translatesAutoresizingMaskIntoConstraints = !autoLayout
        /*************** layout ***************/
        var startPadding:CGFloat = 0
        var endPadding:CGFloat = 0
        switch edgeType {
        case .startPoint,.allPoint:
            startPadding += padding
            if edgeType == .allPoint {
                fallthrough
            }
        case .endPoint:
            endPadding += padding
        }
        if border.translatesAutoresizingMaskIntoConstraints {
            boderLength -= startPadding + endPadding
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
            switch direction {
            case .top, .bottom:
                self.addConstraint(NSLayoutConstraint(item: border, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: startPadding))
                self.addConstraint(NSLayoutConstraint(item: border, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -endPadding))
                self.addConstraint(NSLayoutConstraint(item: border, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: boderWidth))
                if direction == .top {
                    self.addConstraint(NSLayoutConstraint(item: border, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
                }else {
                    self.addConstraint(NSLayoutConstraint(item: border, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
                }
            case .left, .right:
                self.addConstraint(NSLayoutConstraint(item: border, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: startPadding))
                self.addConstraint(NSLayoutConstraint(item: border, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -endPadding))
                self.addConstraint(NSLayoutConstraint(item: border, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: boderWidth))
                if direction == .left {
                    self.addConstraint(NSLayoutConstraint(item: border, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
                }else {
                    self.addConstraint(NSLayoutConstraint(item: border, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))
                }
            }
        }
    }
}
