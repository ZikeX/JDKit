//
//  BaseTableViewHeaderView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/8.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class BaseTableViewHeaderView: UIView {
    lazy var disposeBag = DisposeBag()
    
    lazy var stackView:UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, spacing: 10)
        return stackView
    }()
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
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let result = super.hitTest(point, with: event),
            result != self {
            return result
        }else {
            return nil
        }
    }

}
