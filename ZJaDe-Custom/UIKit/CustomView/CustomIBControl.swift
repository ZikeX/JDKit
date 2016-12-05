//
//  CustomIBControl.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
@IBDesignable
class CustomIBControl: UIControl,CustomIBProtocol {
    override var contentHorizontalAlignment: UIControlContentHorizontalAlignment {
        didSet {
            self.layoutContentView(contentView!)
        }
    }
    override var contentVerticalAlignment: UIControlContentVerticalAlignment {
        didSet {
            self.layoutContentView(contentView!)
        }
    }
    fileprivate var contentView:UIView? {
        didSet {
            if oldValue != contentView {
                if contentView != nil {
                    mainView.addSubview(contentView!)
                    layoutContentView(contentView!)
                }
            }
        }
    }
    let mainView:UIView = {
        let view = UIView()
        return view
    }()
    
    var contentEdgeInsets = UIEdgeInsets() {
        didSet {
            updateMainViewLayout()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configInit()
        self.viewDidLoad()
        self.configNeedUpdate()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewDidLoad()
        self.configNeedUpdate()
    }
    func configInit() {
        updateMainViewLayout()
    }
    func viewDidLoad() {
        
    }
}
extension CustomIBControl {
    func updateMainViewLayout() {
        self.insertSubview(self.mainView, at: 0)
        self.mainView.remakeLayoutView { (view, maker) in
            maker.edges.equalToSuperview().inset(self.contentEdgeInsets)
        }
    }
}
extension CustomIBControl {
    func updateContentView() -> UIView? {
        return nil
    }
    func setNeedUpdateContentView() {
        self.mainView.removeAllSubviews()
        self.contentView = self.updateContentView()
    }
    func layoutContentView(_ contentView:UIView) {
        contentView.snp.remakeConstraints({ (maker) in
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
}
