//
//  JDSegmentedControl.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/11.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import JDSegmentedControl
import RxSwift
import RxCocoa

enum JDSegmentedControlStyle {
    case wavyLine
    case canScroll
}
private var jd_JDSegmentedControlStyleKey = 0
extension JDSegmentedControl {
    var style:JDSegmentedControlStyle {
        get {
            return objc_getAssociatedObject(self, &jd_JDSegmentedControlStyleKey) as? JDSegmentedControlStyle ?? .canScroll
        }
        set {
            objc_setAssociatedObject(self, &jd_JDSegmentedControlStyleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    convenience init(style:JDSegmentedControlStyle) {
        self.init()
        self.style = style
        configWithStyle(style: style)
    }
    func configWithStyle(style:JDSegmentedControlStyle) {
        self.delegate = self
        self.backgroundColor = Color.white
        switch style {
        case .wavyLine:
            self.scrollEnabled = false
            self.addBorderBottom(boderWidth:0.5,color:Color.viewBackground)
        case .canScroll:
            self.scrollEnabled = true
            self.addBorderBottom(boderWidth:0.5,color:Color.tintColor)
        }
        
    }
    override open var intrinsicContentSize: CGSize {
        return CGSize(width: jd.screenWidth, height: 44)
    }
    /// ZJaDe: 获取indicatorImageView
    func indicatorImageView() -> UIImageView {
        let tag = 13
        if let imageView = indicatorView.viewWithTag(tag) as? UIImageView {
            return imageView
        }
        let imageView = UIImageView()
        indicatorView.addSubview(imageView)
        imageView.tag = tag
        return imageView
    }
}
extension JDSegmentedControl:JDSegmentedControlDelegate {
    public func createItem(segmentedControl: JDSegmentedControl, model: JDSegmentedControlModel, isSelectedItem: Bool) -> JDSegmentedControlItem {
        let item = JDSegmentedControlItem()
        item.titleLabel.text = model.title
        item.titleLabel.font = Font.h3
        if isSelectedItem {
            item.titleLabel.textColor = Color.tintColor
        }else {
            item.titleLabel.textColor = Color.black
        }
        return item
    }
    public func layoutItem(segmentedControl:JDSegmentedControl,model:JDSegmentedControlModel,isSelectedItem:Bool) {
        let item = isSelectedItem ? model.selectedItem! : model.item!
        let stackView = UIStackView(alignment:.center,spacing:5)
        if !model.title.isEmpty {
            stackView.addArrangedSubview(item.titleLabel)
        }
        if model.image != nil {
            stackView.addArrangedSubview(item.imageView)
        }
        item.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
        }
        switch segmentedControl.style {
        case .wavyLine:
            break
        case .canScroll:
            item.snp.makeConstraints { (maker) in
                maker.width.equalTo(72)
            }
        }
    }
    public func configIndicatorView(segmentedControl: JDSegmentedControl) {
        let imageView = segmentedControl.indicatorImageView()
        
        switch segmentedControl.style {
        case .wavyLine:
            imageView.tintColor = Color.tintColor
            imageView.image = R.image.ic_wavyLine()?.resizableImage(withCapInsets: UIEdgeInsets(), resizingMode: .tile)
//            imageView.contentMode = .left
            imageView.snp.makeConstraints({ (maker) in
                maker.centerX.equalToSuperview()
                maker.bottom.equalToSuperview().offset(-5)
                maker.width.equalTo(0)
            })
        case .canScroll:
            imageView.backgroundColor = Color.tintColor
            imageView.snp.makeConstraints({ (maker) in
                maker.left.bottom.centerX.equalToSuperview()
                maker.height.equalTo(2)
            })
        }
    }
    public func didSelectedItem(segmentedControl: JDSegmentedControl, index: Int) {
        segmentedControl.indicatorViewAnimate {
            if let item = segmentedControl.modelArray[index].item {
                let indicatorView = segmentedControl.indicatorView
                indicatorView.frame = item.frame
                /// ZJaDe:
                let imageView = segmentedControl.indicatorImageView()
                switch segmentedControl.style {
                case .wavyLine:
                    imageView.snp.updateConstraints { (maker) in
                        let width = CGFloat(item.titleLabel.text!.length + 1) * R.image.ic_wavyLine()!.size.width
                        maker.width.equalTo(width)
                    }
                case .canScroll:
                    break
                }
            }
        }
    }
}
extension Reactive where Base: JDSegmentedControl {
    var value: ControlProperty<Int> {
        return UIControl.rx.valuePublic(
            control: self.base,
            getter: { segmentedControl in
                segmentedControl.selectedSegmentIndex
            }, setter: { segmentedControl, value in
                segmentedControl.selectedSegmentIndex = value
            }
        )
    }
    
}
