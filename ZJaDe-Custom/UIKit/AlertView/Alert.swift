//
//  Alert.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class Alert: WindowBgView {
    fileprivate let itemTitleArray:[String]
    init(itemTitleArray:[String]? = ["确定"],cancelTitle:String = "取消") {
        self.itemTitleArray = itemTitleArray ?? []
        super.init()
        self.cancelButton.textStr = cancelTitle
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -
    let baseView = UIView()
    let contentView = UIView()
    lazy var bottomStackView:UIStackView = {
        let stackView = UIStackView(alignment: .fill, distribution: .fillEqually)
        stackView.addArrangedSubview(self.cancelButton)
        self.itemTitleArray.enumerated().forEach { (index,title) in
            stackView.addArrangedSubview(self.createButton(index: index,title: title))
        }
        stackView.arrangedSubviews.dropLast().forEach({ (view) in
            view.addBorderRight(padding:5)
        })
        return stackView
    }()
    lazy var titleButton:Button = {
        let button = Button()
        button.tintColor = Color.black
        button.textLabel.font = Font.h1
        return button
    }()
    lazy var cancelButton:Button = {
        let button = Button()
        button.textLabel.font = Font.h1
        button.rx.touchUpInside({[unowned self] (button) in
            self.cancelClosure?()
            Alert.hide()
        })
        return button
    }()
    // MARK: - closure
    typealias AlertCallBackClosure = (Int)->()
    typealias AlertCancelClosure = ()->()
    fileprivate var clickClosure:AlertCallBackClosure?
    fileprivate var cancelClosure:AlertCancelClosure?
    // MARK: -
    var tinColor:UIColor? {
        didSet {
            self.bottomStackView.subviews.forEach { (view) in
                view.tintColor = tinColor
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView.cornerRadius = 5
        self.baseView.backgroundColor = Color.white
        self.configLayout()
        self.configShowAnimate(animated: false) {[unowned self] in
            self.view.addSubview(self.baseView)
            self.showAnimation()
        }
        self.tinColor = Color.black
    }
}
extension Alert {
    fileprivate func configLayout() {
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.snp.makeConstraints { (maker) in
            maker.height.equalTo(64).priority(999)
        }
        self.titleButton.snp.makeConstraints { (maker) in
            maker.height.equalTo(64).priority(999)
        }
        
        let stackView = UIStackView(arrangedSubviews: [self.titleButton,self.contentView,bottomStackView])
        stackView.axis = .vertical
        self.baseView.addSubview(stackView)
        stackView.edgesToView()
    }
    fileprivate func createButton(index:Int,title:String) -> Button {
        let button = Button(title: title)
        button.textLabel.font = Font.h1
        if index < itemTitleArray.count - 1 {
            button.addBorderRight(padding:5)
        }
        button.rx.touchUpInside({[unowned self] (button) in
            self.clickClosure?(index)
            Alert.hide()
        })
        return button
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
extension Alert {
    fileprivate func showAnimation(_ animationStyle: AlertAnimationStyle = .topToBottom, animationStartOffset: CGFloat = -400.0, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.75) {
        
        let rv = jd.keyWindow
        var animationStartOrigin = self.baseView.origin
        var animationCenter : CGPoint = rv.center
        
        switch animationStyle {
            
        case .noAnimation:
            return;
            
        case .topToBottom:
            animationStartOrigin.y += animationStartOffset
            animationCenter.y += boundingAnimationOffset
            
        case .bottomToTop:
            animationStartOrigin.y -= animationStartOffset
            animationCenter.y -= boundingAnimationOffset
            
        case .leftToRight:
            animationStartOrigin.x += animationStartOffset
            animationCenter.x += boundingAnimationOffset
            
        case .rightToLeft:
            animationStartOrigin.x -= animationStartOffset
            animationCenter.x -= boundingAnimationOffset
        }
        
        self.baseView.origin = animationStartOrigin
        self.baseView.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        UIView.animate(withDuration: animationDuration, animations: {
            self.baseView.center = animationCenter
            self.baseView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { finished in
            UIView.spring(duration: animationDuration, animations: {
                self.baseView.center = rv.center
                self.baseView.transform = CGAffineTransform.identity
            })
        })
    }
}
