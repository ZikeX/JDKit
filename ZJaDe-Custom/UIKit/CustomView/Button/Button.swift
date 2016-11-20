//
//  Button.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/12.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum TitleAndImgLocation:Int {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

class Button: CustomIBControl {
    
    /// ZJaDe: contentView 根据情况不同，等于下面三个View中的一个
    fileprivate var contentView:UIView? {
        didSet {
            if oldValue != contentView {
                layoutContentView()
            }
        }
    }
    var stackView = UIStackView()
    var textLabel = UILabel()
    @IBInspectable var imgView = ImageView()
    
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
        didSet {
            self.updateText()
        }
    }
    @IBInspectable var img:UIImage? {
        didSet {
            self.updateImg()
        }
    }
    @IBInspectable var isTemplate: Bool = false {
        didSet {
            self.updateImg()
        }
    }
    @IBInspectable var labelFont:Int = 0 {
        didSet {
            self.textLabel.font = Font.num(num: labelFont)
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

    // MARK: -
    //如果 title或者image为空，代表没有对应的Label或者imgView
    convenience init(title:String? = nil,image:UIImage? = nil,isTemplate:Bool = false) {
        self.init(frame:CGRect())
        self.textStr = title
        self.img = image
        self.isTemplate = isTemplate
        self.updateImg()
        self.updateText()
    }
    override func configInit() {
        super.configInit()
        configStackView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        observeConfig()
    }
}
extension Button {
    func updateText() {
        self.textLabel.text = self.textStr
    }
    func updateImg() {
        if isTemplate == true {
            self.imgView.image = self.img?.templateImage
        }else {
            self.imgView.image = self.img?.originalImage
        }
    }
    @IBInspectable override var tintColor: UIColor! {
        didSet {
            self.textLabel.textColor = tintColor
            self.imgView.tintColor = tintColor
            self.layer.borderColor = tintColor.cgColor
        }
    }
}
extension Button {
    func observeConfig() {
        let imgViewImgObserve = self.imgView.rx.observe(UIImage.self, "image")
        let textLabelTextObserve = self.textLabel.rx.observe(String.self, "text")
        Observable.combineLatest(imgViewImgObserve, textLabelTextObserve) {($0, $1)}.distinctUntilChanged{ [unowned self] in
            return self.checkEmptyEqual($0,$1)
            }.subscribe(onNext: {[unowned self] (event) in
                self.updateSubViews()
            }).addDisposableTo(disposeBag)
    }
    func checkEmptyEqual<I:Equatable,T:Equatable>(_ element1:(I?,T?),_ element2:(I?,T?)) -> Bool {
        let firstIsEqual = (element1.0 == nil && element2.0 == nil) || (element1.0 != nil && element2.0 != nil)
        let secondIsEqual = (element1.1 == nil && element2.1 == nil) || (element1.1 != nil && element2.1 != nil)
        return firstIsEqual && secondIsEqual
    }
}

extension Button {
    func updateSubViews() {
        self.removeAllSubviews()
        switch (self.imgView.image,self.textLabel.text) {
        case (nil,nil):
            break
        case (nil,_):
            self.addSubview(self.textLabel)
        case (_,nil):
            self.addSubview(self.imgView)
        case (_,_):
            self.addSubview(self.stackView)
            self.addAndSortStackSubViews()
        }
        self.contentView = self.subviews.first
    }
    func layoutContentView() {
        self.contentView?.snp.remakeConstraints({ (maker) in
            switch self.contentHorizontalAlignment {
            case .center:
                maker.centerX.equalToSuperview()
                maker.left.greaterThanOrEqualToSuperview()
            case .fill:
                maker.left.equalToSuperview()
                maker.right.equalToSuperview()
            case .left:
                maker.left.equalToSuperview()
                maker.right.lessThanOrEqualToSuperview()
            case .right:
                maker.left.greaterThanOrEqualToSuperview()
                maker.right.equalToSuperview()
            }
            switch self.contentVerticalAlignment {
            case .center:
                maker.centerY.equalToSuperview()
                maker.top.greaterThanOrEqualToSuperview()
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
//        #if TARGET_INTERFACE_BUILDER
//            return CGSize(width: 70, height: 30)
//        #endif
        
        var jdwidth:CGFloat = contentEdgeInsets.left + contentEdgeInsets.right
        var jdheight:CGFloat = contentEdgeInsets.top + contentEdgeInsets.bottom
        
        let titleSize = textLabel.intrinsicContentSize
        let imageSize = imgView.intrinsicContentSize
        switch (self.imgView.image,self.textLabel.text) {
        case (nil,nil):
            return CGSize(width: 60, height: 30)
        case (nil,_):
            jdwidth += titleSize.width
            jdheight += titleSize.height
        case (_,nil):
            jdwidth += imageSize.width
            jdheight += imageSize.height
        default:
            switch self.stackView.axis {
            case .horizontal:
                jdwidth += imageSize.width + titleSize.width + stackView.spacing
                jdheight += max(imageSize.height,titleSize.height)
            case .vertical:
                jdwidth += max(imageSize.width,titleSize.width)
                jdheight += imageSize.height + titleSize.height + stackView.spacing
            }
        }
        return CGSize(width: jdwidth, height: jdheight)
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
        self.stackView.removeAllSubviews()
        if titleInLeading {
            self.stackView.addArrangedSubview(self.textLabel)
            self.stackView.addArrangedSubview(self.imgView)
        }else {
            self.stackView.addArrangedSubview(self.imgView)
            self.stackView.addArrangedSubview(self.textLabel)
            
        }
    }
}
extension Reactive where Base: Button {
    internal var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
