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
        self.configShowAnimate(animated: false) {[unowned self] in
            self.view.addSubview(self.baseView)
            self.showAnimation()
        }
    }
}
extension Alert {
    func configLayout() {
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
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
        return self
    }
    @discardableResult
    func configClick(_ closure:@escaping (Int)->()) -> Alert {
        self.clickClosure = closure
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
