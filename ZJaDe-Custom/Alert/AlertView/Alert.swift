//
//  Alert.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class Alert: BaseAlert {
    convenience init(confirmTitle:String = alertConfirmTitle, cancelTitle:String = alertCancelTitle) {
        self.init()
        self.confirmButton.textStr = confirmTitle
        self.cancelButton.textStr = cancelTitle
    }
    // MARK: -

    let contentView = UIView()
    lazy var bottomStackView:UIStackView = {
        let stackView = UIStackView(alignment: .fill, distribution: .fillEqually)
        stackView.addArrangedSubview(self.cancelButton)
        stackView.addArrangedSubview(self.confirmButton)
        self.confirmButton.addBorderLeft(padding:5)
        return stackView
    }()
    lazy var titleButton:Button = {
        let button = Button(title:alertTitle)
        button.tintColor = Color.black
        button.textLabel.font = Font.h1
        return button
    }()
    lazy var cancelButton:Button = {
        let button = Button(title:alertCancelTitle)
        button.textLabel.font = Font.h2
        button.textLabel.textColor = Color.gray
        button.rx.touchUpInside({[unowned self] (button) in
            self.cancelClosure?()
            self.hide()
        })
        return button
    }()
    lazy var confirmButton:Button = {
        let button = Button(title:alertConfirmTitle)
        button.textLabel.font = Font.h2
        button.textLabel.textColor = Color.gray
        button.rx.touchUpInside({[unowned self] (button) in
            self.clickClosure?()
            self.hide()
        })
        return button
    }()
    // MARK: - closure
    typealias AlertCallBackClosure = ()->()
    typealias AlertCancelClosure = ()->()
    fileprivate var clickClosure:AlertCallBackClosure?
    fileprivate var cancelClosure:AlertCancelClosure?
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configBaseLayout() {
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.snp.makeConstraints { (maker) in
            maker.height.equalTo(64).priority(999)
        }
        self.titleButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(64).priority(999)
        }
        
        let stackView = UIStackView(arrangedSubviews: [self.titleButton,self.contentView,self.bottomStackView])
        stackView.axis = .vertical
        self.baseView.addSubview(stackView)
        stackView.edgesToView()
    }
}

extension Alert {
    @discardableResult
    func configShowLayout(_ closure:(Alert,UIView)->()) -> Alert {
        closure(self,self.contentView)
        return self
    }
    @discardableResult
    func configClick(_ closure:AlertCallBackClosure?) -> Alert {
        self.clickClosure = closure
        return self
    }
    @discardableResult
    func configCancel(_ closure:AlertCancelClosure?) -> Alert {
        self.cancelClosure = closure
        return self
    }
}
