//
//  Button.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/12.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum TitleAndImgLocation:Int {
    case leftToRight = 0
    case rightToLeft = 1
    case topToBottom = 2
    case bottomToTop = 3
}
@IBDesignable
class Button: UIControl {
    let disposeBag = DisposeBag()
    
    lazy private(set) var stackView = UIStackView()
    let textLabel = UILabel()
    let imgView = UIImageView()
    @IBInspectable var textStr:String? = nil {
        didSet {
            self.textLabel.text = textStr
        }
    }
    @IBInspectable var img:UIImage? = nil {
        didSet {
            self.imgView.image = img
        }
    }
    @IBInspectable var contentEdgeInsets = UIEdgeInsets()
    @IBInspectable var titleAndImgLocation:TitleAndImgLocation {
        get {
            for (key,value) in locationDict {
                if value.0 == titleInLeading && value.1 == stackView.axis {
                    return key
                }
            }
            return .leftToRight
        }
        set {
            if let (titleInLeading,axis) = locationDict[newValue] {
                self.titleInLeading = titleInLeading
                self.stackView.axis = axis
            }
        }
    }
    var titleInLeading = true {
        didSet {
            addAndSortStackSubViews()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            self.textLabel.textColor = tintColor
            self.imgView.tintColor = tintColor
        }
    }
    //如果 title或者image为空，代表没有对应的Label或者imgView
    convenience init(title:String? = nil,image:UIImage? = nil) {
        self.init(frame:CGRect())
        self.textLabel.text = title
        self.imgView.image = image
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configInit() {
        configStackView()
        observeConfig()
    }
}
extension Button {
    func observeConfig() {
        let imgViewImgObserve = self.imgView.rx.observe(UIImage.self, "image")
        let textLabelTextObserve = self.textLabel.rx.observe(String.self, "text")
        Observable.combineLatest(imgViewImgObserve, textLabelTextObserve) {($0, $1)}.distinctUntilChanged{$0.0 == $1.0 && $0.1 == $1.1}.subscribe({ (event) in
            self.configSubViews(element: event.element)
        }).addDisposableTo(disposeBag)
    }
}
extension Button {
    func configSubViews(element:(UIImage?,String?)?) {
        self.removeAllSubviews()
        self.stackView.removeAllSubviews()
        switch element {
        case (nil,nil)?,nil:
            break
        case (nil,_)?:
            self.addSubview(self.textLabel)
            self.textLabel.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.left.greaterThanOrEqualTo(self)
                maker.top.greaterThanOrEqualTo(self)
            })
        case (_,nil)?:
            self.addSubview(self.imgView)
            self.imgView.snp.makeConstraints({ (maker) in
                maker.center.equalToSuperview()
                maker.left.greaterThanOrEqualTo(self)
                maker.top.greaterThanOrEqualTo(self)
            })
        case (_,_)?:
            self.addSubview(self.stackView)
            self.stackView.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
            }
            self.addAndSortStackSubViews()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self.intrinsicContentSize
    }
    override var intrinsicContentSize:CGSize {
        var width:CGFloat = contentEdgeInsets.left + contentEdgeInsets.right
        var height:CGFloat = contentEdgeInsets.top + contentEdgeInsets.bottom
        
        switch (self.imgView.image,self.textLabel.text) {
        case (nil,nil):
            break
        case (nil,_):
            let titleSize = textLabel.intrinsicContentSize
            width += titleSize.width
            height += titleSize.height
        case (_,nil):
            let imageSize = imgView.intrinsicContentSize
            width += imageSize.width
            height += imageSize.height
        case (_,_):
            let imageSize = imgView.intrinsicContentSize
            let titleSize = textLabel.intrinsicContentSize
            switch self.stackView.axis {
            case .horizontal:
                width = imageSize.width + titleSize.width + stackView.spacing
                height = max(imageSize.height,titleSize.height)
            case .vertical:
                height = imageSize.height + titleSize.height + stackView.spacing
                width = max(imageSize.width,titleSize.width)
            }
        }
        return CGSize(width: width, height: height)
    }
}
extension Button {
    func configStackView() {
        self.stackView.isUserInteractionEnabled = false
        self.stackView.spacing = 5
        self.stackView.alignment = .center
    }
    
    var locationDict:[TitleAndImgLocation:(Bool,UILayoutConstraintAxis)] {
        return [
        .leftToRight:(true,.horizontal),
        .rightToLeft:(false,.horizontal),
        .topToBottom:(true,.vertical),
        .bottomToTop:(false,.vertical)]
    }
    func addAndSortStackSubViews() {
        let titleIndex = titleInLeading ? 0 : 1
        let imageIndex = titleInLeading ? 1 : 0
        self.stackView.insertArrangedSubview(self.textLabel, at: titleIndex)
        self.stackView.insertArrangedSubview(self.imgView, at: imageIndex)
    }
}
extension Reactive where Base: Button {
    internal var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}