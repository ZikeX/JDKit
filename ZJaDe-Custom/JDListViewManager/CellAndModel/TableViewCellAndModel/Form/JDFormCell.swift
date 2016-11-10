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

class JDFormCell: JDTableViewCell {
    
    let stackView = UIStackView(alignment: .center ,spacing:8)
    var titleLabel = UILabel()
    var imgView = ImageView()
    var jdFocusView:UIView?
    
    override func configCellInit() {
        super.configCellInit()
        appearAnimatedStyle = .showOut
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
    override func cellDidLoad(_ element: JDTableViewModel) {
        super.cellDidLoad(element)
        guard let formModel = element as? JDFormModel else {
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
    override func configCellWithElement(_ element: JDTableViewModel) {
        super.configCellWithElement(element)
        guard let formModel = element as? JDFormModel else {
            return
        }
        if !formModel.imageIsEmpty {
            formModel.image.asObservable().bindTo(imgView.rx.image).addDisposableTo(disposeBag)
            formModel.imageViewAppearanceClosure(imgView)
        }
        if !formModel.titleIsEmpty {
            formModel.title.asObservable().bindTo(titleLabel.rx.text).addDisposableTo(disposeBag)
            formModel.titleLabelAppearanceClosure(titleLabel)
        }
        formModel.cellAppearanceClosure(self)
        
    }
    override func cellUpdateConstraints(_ element: JDTableViewModel) {
        super.cellUpdateConstraints(element)
        guard let formModel = element as? JDFormModel else {
            return
        }
        if !formModel.titleIsEmpty && !formModel.imageIsEmpty {
            imgView.snp.makeConstraints({ (maker) in
                maker.height.equalTo(titleLabel.intrinsicContentSize.height)
            })
        }
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
