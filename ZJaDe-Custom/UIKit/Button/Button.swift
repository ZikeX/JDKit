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
    
    /// ZJaDe: contentView 根据情况不同，等于下面三个View中的一个
    fileprivate var contentView:UIView? {
        didSet {
            if oldValue != contentView {
                layoutContentView()
            }
        }
    }
    lazy private(set) var stackView = UIStackView()
    let textLabel = UILabel()
    let imgView = UIImageView()
    
    var contentEdgeInsets = UIEdgeInsets()
    var titleAndImgLocation:TitleAndImgLocation {
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
    // MARK: - @IBInspectable
    @IBInspectable var textStr:String? {
        get {
            return self.textLabel.text
        }
        set {
            self.textLabel.text = newValue
        }
    }
    @IBInspectable var img:UIImage? {
        get {
            return self.imgView.image
        }
        set {
            if isTemplate {
                self.imgView.image = newValue?.templateImage
            }else {
                self.imgView.image = newValue
            }
        }
    }
    @IBInspectable var labelFont:Int = 0 {
        didSet {
            self.textLabel.font = Font.size(num: labelFont)
        }
    }
    @IBInspectable var itemSpace:CGFloat {
        get {
            return self.stackView.spacing
        }
        set {
            self.stackView.spacing = newValue
        }
    }
    @IBInspectable var isTemplate: Bool = false
    
    @IBInspectable var titleInLeading: Bool = true {
        didSet {
            addAndSortStackSubViews()
        }
    }
    @IBInspectable var isHorizontal: Bool {
        get {
            return self.stackView.axis == .horizontal
        }
        set {
            self.stackView.axis = newValue ? .horizontal : .vertical
        }
    }
    @IBInspectable override var tintColor: UIColor! {
        didSet {
            self.textLabel.textColor = tintColor
            self.imgView.tintColor = tintColor
        }
    }
    @IBInspectable var IBSize:CGSize = CGSize()

    // MARK: -
    //如果 title或者image为空，代表没有对应的Label或者imgView
    convenience init(title:String? = nil,image:UIImage? = nil) {
        self.init(frame:CGRect())
        self.textLabel.text = title
        if isTemplate {
            self.imgView.image = image?.templateImage
        }else {
            self.imgView.image = image
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
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
        Observable.combineLatest(imgViewImgObserve, textLabelTextObserve) {($0, $1)}.distinctUntilChanged{ [unowned self] in
            return self.checkEmptyEqual($0,$1)
        }.subscribe({ (event) in
            self.configSubViews(element: event.element)
        }).addDisposableTo(disposeBag)
    }
    func checkEmptyEqual<I:Equatable,T:Equatable>(_ element1:(I?,T?),_ element2:(I?,T?)) -> Bool {
        let firstIsEqual = (element1.0 == nil && element2.0 == nil) || (element1.0 != nil && element2.0 != nil)
        let secondIsEqual = (element1.1 == nil && element2.1 == nil) || (element1.1 != nil && element2.1 != nil)
        return firstIsEqual && secondIsEqual
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
        case (_,nil)?:
            self.addSubview(self.imgView)
        case (_,_)?:
            self.addSubview(self.stackView)
            self.addAndSortStackSubViews()
        }
        self.contentView = self.subviews.first
    }
    func layoutContentView() {
        self.contentView?.snp.makeConstraints({ (maker) in
            switch self.contentHorizontalAlignment {
            case .center:
                maker.centerX.equalToSuperview()
                maker.left.greaterThanOrEqualTo(self)
                maker.right.lessThanOrEqualTo(self)
            case .fill:
                maker.left.equalToSuperview()
                maker.right.equalToSuperview()
            case .left:
                maker.left.equalToSuperview()
                maker.right.lessThanOrEqualTo(self)
            case .right:
                maker.left.greaterThanOrEqualTo(self)
                maker.right.equalToSuperview()
            }
            switch self.contentVerticalAlignment {
            case .center:
                maker.centerY.equalToSuperview()
                maker.top.greaterThanOrEqualTo(self)
                maker.bottom.lessThanOrEqualTo(self)
            case .fill:
                maker.top.equalToSuperview()
                maker.bottom.equalToSuperview()
            case .top:
                maker.top.equalToSuperview()
                maker.bottom.lessThanOrEqualTo(self)
            case .bottom:
                maker.top.greaterThanOrEqualTo(self)
                maker.bottom.equalToSuperview()
            }
        })
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return self.intrinsicContentSize
    }
    override var intrinsicContentSize:CGSize {
        #if TARGET_INTERFACE_BUILDER
            return self.IBSize
        #endif
        var width:CGFloat = contentEdgeInsets.left + contentEdgeInsets.right
        var height:CGFloat = contentEdgeInsets.top + contentEdgeInsets.bottom
        
        switch (self.img,self.textStr) {
        case (nil,nil):
            return CGSize(width: 60, height: 30)
        case (nil,_):
            let titleSize = textLabel.intrinsicContentSize
            width = width + titleSize.width
            height = height + titleSize.height
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
