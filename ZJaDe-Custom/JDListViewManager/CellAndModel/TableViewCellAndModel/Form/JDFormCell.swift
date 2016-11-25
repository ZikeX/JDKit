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

class JDFormCell: JDStaticCell {
    
    let stackView = UIStackView(alignment: .center ,spacing:8)
    var titleLabel = UILabel()
    
    var imgView = ImageView()
    
    override func configCellInit() {
        super.configCellInit()
        jdContentView.addSubview(stackView)
        stackView.snp.makeConstraints { (maker) in
            maker.left.top.equalToSuperview()
            maker.height.greaterThanOrEqualTo(28)
            maker.bottom.lessThanOrEqualTo(jdContentView)
        }
        titleLabel.contentPriority(UILayoutPriorityRequired)
        stackView.contentPriority(UILayoutPriorityRequired)
    }
}
extension JDFormCell {
    override func configCell(_ model: JDTableModel) {
        super.configCell(model)
        guard let formModel = model as? JDFormModel else {
            return
        }
        if !formModel.imageIsEmpty {
            stackView.addArrangedSubview(imgView)
        }
        if !formModel.titleIsEmpty {
            stackView.addArrangedSubview(titleLabel)
        }
    }
    override func bindingModel(_ model: JDTableModel) {
        super.bindingModel(model)
        guard let formModel = model as? JDFormModel else {
            return
        }
        formModel.accessoryType.asObservable().subscribe (onNext: {[unowned self] (accessoryType) in
            self.accessoryType = accessoryType
        }).addDisposableTo(disposeBag)
        if !formModel.imageIsEmpty {
            formModel.image.asObservable().bindTo(imgView.rx.image).addDisposableTo(disposeBag)
        }
        if !formModel.titleIsEmpty {
            formModel.title.asObservable().bindTo(titleLabel.rx.text).addDisposableTo(disposeBag)
            configTitleLabel(titleLabel: titleLabel)
        }
    }
    override func didBindingModel(_ model: JDTableModel) {
        super.didBindingModel(model)
        guard let formModel = model as? JDFormModel else {
            return
        }
        if !formModel.titleIsEmpty && !formModel.imageIsEmpty {
            imgView.snp.remakeConstraints({ (maker) in
                let imageSize = formModel.image.value!.size
                maker.height.equalTo(titleLabel.intrinsicContentSize.height)
                maker.width_height(scale: imageSize.width / imageSize.height)
            })
        }
    }
}
extension JDFormCell {
    func configTitleLabel(titleLabel:UILabel) {
        titleLabel.textColor = Color.black
        titleLabel.font = Font.h3
        titleLabel.numberOfLines = 1
    }
}
