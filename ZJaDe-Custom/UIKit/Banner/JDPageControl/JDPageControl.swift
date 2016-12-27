//
//  JDPageControl.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/24.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class JDPageControl: UIControl {
    @IBInspectable var currentPage: Int?
    @IBInspectable var numberOfPages: Int = 0 {
        didSet {
            guard let delegate = self.delegate else {
                return
            }
            configItemArray(delegate: delegate, count: numberOfPages)
        }
    }
    @IBInspectable var hidesForSinglePage: Bool = false
    @IBInspectable var pageIndicatorTintColor: UIColor = Color.red
    @IBInspectable var currentPageIndicatorTintColor: UIColor = Color.black
    
    weak var delegate:JDPageControlDelegate?
    
    let stackView = UIStackView(alignment: .center, distribution: .equalCentering, spacing: 0)
    
    fileprivate var itemArray = [PageItemView]() {
        didSet {
            self.stackView.removeAllSubviews()
            itemArray.forEach { (view) in
                stackView.addArrangedSubview(view)
                delegate?.layoutItem(itemView: view)
            }
        }
    }
    fileprivate var currentItem:PageItemView? {
        guard let currentPage = self.currentPage,currentPage > 0,currentPage < itemArray.count else {
            logError("currentPage为nil，或者越界")
            return nil
        }
        return self.itemArray[currentPage]
    }
    
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
    }
    
}
extension JDPageControl {
    func configItemArray(delegate:JDPageControlDelegate,count:Int) {
        guard count != self.itemArray.count else {
            return
        }
        var array = [PageItemView]()
        for _ in 0..<count {
            array.append(delegate.createItem())
        }
        self.itemArray = array
    }
}
class PageItemView:UIView {
}
