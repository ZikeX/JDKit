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
enum EmptyViewState {
    case loading
    case loaded
    case loadFailed
}

class EmptyDataSetView: UIView {
    typealias ContentViewType = UIStackView
    typealias EmptyDataSetClosureType = (EmptyViewState,UIStackView) -> ()
    var contentView:ContentViewType = UIStackView()
    
    var contentViewClosure:EmptyDataSetClosureType?
    func configEmptyDataSetData(_ closure:@escaping EmptyDataSetClosureType) {
        self.contentViewClosure = closure
    }
    // MARK: -
    var showState:EmptyShowState = .automatic
    
    fileprivate func reloadData(_ state:EmptyViewState) {
        self.prepareForReuse()
        if checkCanShow() {
            self.addSubview(self.contentView)
            self.contentView.snp.makeConstraints { (maker) in
                maker.center.equalToSuperview()
                maker.left.top.greaterThanOrEqualToSuperview()
            }
            contentViewClosure?(state,contentView)
            self.contentView.setNeedsLayout()
            self.contentView.layoutIfNeeded()
            self.contentViewAnimate(show: true)
        }else {
            self.contentViewAnimate(show: false) {(finish) in
                self.removeFromSuperview()
            }
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
extension UIScrollView {
    func reloadEmptyDataSet(_ state:EmptyViewState) {
        let emptyView = self.emptyDataSetView
        if emptyView.superview == nil {
            self.insertSubview(emptyView, at: 0)
            self.rx.observe(UIEdgeInsets.self, "contentInset", retainSelf: false).subscribe(onNext:{ [unowned self] (edge) in
                var height = self.height - self.contentInset.top
                if height <= 0 {
                    height = 200
                }
                self.emptyDataSetView.frame = CGRect(x: 0, y: 0, width: self.width, height: height)
                if self.contentSize.height <= 0 {
                    self.contentSize.height = self.emptyDataSetView.bottom
                }
            }).addDisposableTo(disposeBag)
        }
        self.emptyDataSetView.reloadData(state)
    }
}
extension EmptyDataSetView {
    func prepareForReuse() {
        self.contentView.removeAllSubviews()
        self.contentView.removeFromSuperview()
        self.contentView.then { (contentView) in
            contentView.axis = .vertical
            contentView.alignment = .center
            contentView.distribution = .equalCentering
            contentView.spacing = 0
        }
    }
    func contentViewAnimate(show:Bool,completion: ((Bool) -> Void)? = nil) {
        if show {
            self.contentView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            self.contentView.alpha = 0
            UIView.spring(duration: 0.25, animations: {
                self.contentView.alpha = 1
                self.contentView.transform = CGAffineTransform.identity
            }, completion: completion)
        }else {
            UIView.spring(duration: 0.25, animations: { 
                self.contentView.alpha = 0
            }, completion: completion)
        }
    }
    override func didMoveToSuperview() {
        if self.superview != nil {
            self.frame = self.superview!.bounds
        }
    }
}
