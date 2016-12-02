//
//  Alert.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/29.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class Alert: WindowBgView {
    var itemTitleArray:[String]
    init(itemTitleArray:[String] = ["确定"]) {
        self.itemTitleArray = itemTitleArray
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: -
    var baseView = UIView()
    var contentView = UIView()
    lazy var titleLabel:UILabel = {
        let label = UILabel(color: Color.black, font: Font.h1)
        label.textAlignment = .center
        return label
    }()
    lazy var cancelLabel:Button = {
        let button = Button(title: "取消")
        button.textLabel.font = Font.h1
        button.addBorderRight(padding:5)
        button.rx.touchUpInside({[unowned self] (button) in
            Alert.hide()
        })
        return button
    }()
    // MARK: - closure
    fileprivate var clickClosure:((Int)->())?
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseView.cornerRadius = 5
        self.baseView.backgroundColor = Color.white
        self.configLayout()
    }
}
extension Alert {
    func configLayout() {
        let bottomStackView = UIStackView(arrangedSubviews: [self.cancelLabel])
        bottomStackView.distribution = .fillEqually
        bottomStackView.heightValue(height: 64)
        itemTitleArray.enumerated().forEach { (index,title) in
            bottomStackView.addArrangedSubview(createButton(index: index,title: title))
        }
        
        titleLabel.heightValue(height: 64)
        
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel,self.contentView,bottomStackView])
        stackView.axis = .vertical
        self.baseView.addSubview(stackView)
        stackView.edgesToView()
    }
    func createButton(index:Int,title:String) -> Button {
        let button = Button(title: title)
        button.textLabel.font = Font.h1
        if index < itemTitleArray.count - 1 {
            button.addBorderRight(padding:5)
        }
        button.rx.touchUpInside({[unowned self] (button) in
            self.clickClosure?(index)
        })
        return button
    }
}
extension Alert {
    @discardableResult
    func configShowLayout(_ closure:(Alert,UIView)->()) -> Alert {
        closure(self,self.contentView)
        self.show()
        return self
    }
    @discardableResult
    func configClick(_ closure:@escaping (Int)->()) -> Alert {
        self.clickClosure = closure
        return self
    }
}
extension Alert {
    fileprivate func showAnimation(_ animationStyle: AlertAnimationStyle = .topToBottom, animationStartOffset: CGFloat = -400.0, boundingAnimationOffset: CGFloat = 15.0, animationDuration: TimeInterval = 0.2) {
        
        let rv = UIApplication.shared.keyWindow! as UIWindow
        var animationStartOrigin = self.baseView.frame.origin
        var animationCenter : CGPoint = rv.center
        
        switch animationStyle {
            
        case .noAnimation:
            self.view.alpha = 1.0
            return;
            
        case .topToBottom:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y + animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y + boundingAnimationOffset)
            
        case .bottomToTop:
            animationStartOrigin = CGPoint(x: animationStartOrigin.x, y: self.baseView.frame.origin.y - animationStartOffset)
            animationCenter = CGPoint(x: animationCenter.x, y: animationCenter.y - boundingAnimationOffset)
            
        case .leftToRight:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x + animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x + boundingAnimationOffset, y: animationCenter.y)
            
        case .rightToLeft:
            animationStartOrigin = CGPoint(x: self.baseView.frame.origin.x - animationStartOffset, y: animationStartOrigin.y)
            animationCenter = CGPoint(x: animationCenter.x - boundingAnimationOffset, y: animationCenter.y)
        }
        
        self.baseView.frame.origin = animationStartOrigin
        UIView.animate(withDuration: animationDuration, animations: {
            self.view.alpha = 1.0
            self.baseView.center = animationCenter
        }, completion: { finished in
            UIView.animate(withDuration: animationDuration, animations: {
                self.view.alpha = 1.0
                self.baseView.center = rv.center
            })
        })
    }
}
