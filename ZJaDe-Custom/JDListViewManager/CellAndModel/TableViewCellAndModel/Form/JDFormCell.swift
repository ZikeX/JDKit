//
//  JDFormCell.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class JDFormCell: JDTableCell {
    
    let stackView = UIStackView(alignment: .center ,spacing:8)
    var titleLabel = UILabel()
    var imgView = ImageView()
    var jdFocusView:UIView?
    
    override func configCellInit() {
        super.configCellInit()
        appearAnimatedStyle = .fromInsideOut
        highlightAnimatedStyle = .none
        selectedAnimated = false
        
        jdContentView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.height.greaterThanOrEqualTo(28)
            maker.bottom.lessThanOrEqualTo(jdContentView)
        }
        stackView.contentPriority(UILayoutPriorityRequired)
    }
}
extension JDFormCell {
    override func configCell(_ model: JDTableModel) {
        guard let formModel = model as? JDFormModel else {
            return
        }
        if !formModel.imageIsEmpty {
            stackView.addArrangedSubview(imgView)
            let imageSize = formModel.image.value!.size
            imgView.width_height(scale: imageSize.width / imageSize.height)
        }
        if !formModel.titleIsEmpty {
            stackView.addArrangedSubview(titleLabel)
        }
    }
    override func bindingModel(_ model: JDTableModel) {
        guard let formModel = model as? JDFormModel else {
            return
        }
        formModel.accessoryType.asObservable().subscribe { (event) in
            if let accessoryType = event.element {
                self.accessoryType = accessoryType
            }
        }.addDisposableTo(disposeBag)
        self.configCellAppear()
        if !formModel.imageIsEmpty {
            formModel.image.asObservable().bindTo(imgView.rx.image).addDisposableTo(disposeBag)
        }
        if !formModel.titleIsEmpty {
            formModel.title.asObservable().bindTo(titleLabel.rx.text).addDisposableTo(disposeBag)
            configTitleLabel(titleLabel: titleLabel)
        }
    }
    override func didBindingModel(_ model: JDTableModel) {
        guard let formModel = model as? JDFormModel else {
            return
        }
        if !formModel.titleIsEmpty && !formModel.imageIsEmpty {
            imgView.snp.makeConstraints({ (maker) in
                maker.height.equalTo(titleLabel.intrinsicContentSize.height)
            })
        }
    }
}
extension JDFormCell {
    func configTitleLabel(titleLabel:UILabel) {
        titleLabel.textAlignment = .center
        titleLabel.textColor = Color.black
        titleLabel.font = Font.h3
        titleLabel.numberOfLines = 1
    }
    func configCellAppear() {
        
    }
}
extension JDFormCell {//cell第一响应者 焦点View
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.jdFocusView?.becomeFirstResponder()
        }
    }
}
