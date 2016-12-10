//
//  BaseScrollHeaderView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/8.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class BaseScrollHeaderView: UIView {
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, spacing: 10)
        return stackView
    }()
    // MARK: - 子控件
    lazy var segmentedControl:SegmentedControl = {
        let segmentedControl = SegmentedControl(style:.wavyLine)
        return segmentedControl
    }()
    // MARK: -
    init() {
        super.init(frame: CGRect())
        configInit()
        configLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configInit()
    }
    
    func configInit() {
        self.backgroundColor = Color.viewBackground
    }
    
    // MARK: 布局
    func configLayout() {
        self.addSubview(stackView)
        stackView.edgesToView()
    }

}
