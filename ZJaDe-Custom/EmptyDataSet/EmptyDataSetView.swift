//
//  EmptyDataSetView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/18.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

enum EmptyShowState {
    case automatic
    case show
    case hide
}

class EmptyDataSetView: UIView {
    typealias ContentViewType = UIStackView
    var contentView:ContentViewType = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, distribution: .equalCentering, spacing: 0)
        return stackView
    }()
    var contentViewClosure:((ContentViewType) -> ())?
    func configEmptyDataSetData(_ closure:@escaping (ContentViewType) -> ()) {
        self.contentViewClosure = closure
    }
    // MARK: -
    var showState:EmptyShowState = .automatic
    
    func reloadData() {
        self.prepareForReuse()
        if checkCanShow() {
            self.addSubview(self.contentView)
            self.contentView.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
                maker.left.top.greaterThanOrEqualToSuperview()
            }
            contentViewClosure?(contentView)
            UIView.performWithoutAnimation {
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
            self.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.spring(duration: 0.25, animations: { 
                self.contentView.alpha = 1
                self.contentView.transform = CGAffineTransform.identity
            })
        }else {
            UIView.spring(duration: 0.25, animations: {
                self.contentView.alpha = 0
            }, completion: { (finish) in
                self.contentView.removeAllSubviews()
                self.removeAllSubviews()                
            })
        }
    }
    func checkCanShow() -> Bool {
        let scrollView = self.superview! as! UIScrollView
        switch self.showState {
        case .automatic:
            return scrollView.itemsCount == 0
        case .show:
            return true
        case .hide:
            return false
        }
        
    }
}
extension EmptyDataSetView {
    func prepareForReuse() {
        self.contentView.alpha = 0
    }
    override func didMoveToSuperview() {
        self.edgesToView()
    }
}
