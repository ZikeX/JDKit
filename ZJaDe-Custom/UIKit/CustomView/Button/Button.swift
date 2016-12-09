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
    var stackView = UIStackView()
    var textLabel = UILabel()
    var imgView = ImageView()
    
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
            self.imgView.image = newValue
        }
    }
    @IBInspectable var isTemplate: Bool {
        get {
            return self.imgView.isTemplate
        }
        set {
            self.imgView.isTemplate = newValue
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
            if self.titleInLeading != oldValue {
                self.sortStackSubViews()
            }
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
    }
    override func configInit() {
        super.configInit()
        mainView.isUserInteractionEnabled = false
        configStackView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNeedUpdateContentView()
        observeConfig()
    }
}
extension Button {
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
                self.addStackSubViews()
            }).addDisposableTo(disposeBag)
    }
    func checkEmptyEqual<I:Equatable,T:Equatable>(_ element1:(I?,T?),_ element2:(I?,T?)) -> Bool {
        let firstIsEqual = (element1.0 == nil && element2.0 == nil) || (element1.0 != nil && element2.0 != nil)
        let secondIsEqual = (element1.1 == nil && element2.1 == nil) || (element1.1 != nil && element2.1 != nil)
        return firstIsEqual && secondIsEqual
    }
}

extension Button {
    override func updateContentView() -> UIView? {
        return self.stackView
    }
    override var intrinsicContentSize:CGSize {
        #if TARGET_INTERFACE_BUILDER
            return CGSize(width: 70, height: 30)
        #endif
        
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

    func addStackSubViews() {
        switch (self.img,self.textStr) {
        case (nil,nil):
            self.stackView.isHidden = true
        case (_,nil):
            self.stackView.isHidden = false
            self.imgView.isHidden = false
            self.textLabel.isHidden = true
            self.addImageView(true)
        case (nil,_):
            self.stackView.isHidden = false
            self.imgView.isHidden = true
            self.textLabel.isHidden = false
            self.addTextLabel(true)
        case (_,_):
            self.stackView.isHidden = false
            self.imgView.isHidden = false
            self.textLabel.isHidden = false
            if self.stackView.arrangedSubviews.count < 2 {
                self.sortStackSubViews()
            }
        }
    }
    func sortStackSubViews() {
        if titleInLeading {
            self.addTextLabel(true)
            self.addImageView(false)
        }else {
            self.addImageView(true)
            self.addTextLabel(false)
        }
    }
    func addImageView(_ isFirstItem:Bool) {
        if self.img != nil {
            if isFirstItem {
                self.stackView.insertArrangedSubview(self.imgView, at: 0)
            }else {
                self.stackView.addArrangedSubview(self.imgView)
            }
        }
    }
    func addTextLabel(_ isFirstItem:Bool) {
        if self.textStr != nil {
            if isFirstItem {
                self.stackView.insertArrangedSubview(self.textLabel, at: 0)
            }else {
                self.stackView.addArrangedSubview(self.textLabel)
            }
        }
    }
}
extension Reactive where Base: Button {
    internal var tap: ControlEvent<Void> {
        return controlEvent(.touchUpInside)
    }
}
