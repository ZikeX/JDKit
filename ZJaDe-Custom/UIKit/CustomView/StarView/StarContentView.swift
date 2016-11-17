//
//  StarContentView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/16.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

class StarContentView: CustomIBView {
    @IBInspectable var hasSuffix:Bool = true {
        didSet {
            self.suffixLabel.isHidden = hasSuffix
        }
    }
    @IBInspectable var prefix:String = "" {
        didSet {
            self.prefixLabel.text = prefix
        }
    }
    @IBInspectable var score:Score = 0 {
        didSet {
            self.suffixLabel.text = "\(score)分"
            self.starView.score = score
        }
    }
    
    lazy var prefixLabel = UILabel(text: "", color: Color.black, font: Font.h4)
    lazy var suffixLabel = UILabel(text: "0.0分", color: Color.orange, font: Font.h4)
    lazy var starView:StarRatingLogicView = StarRatingLogicView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStackView = UIStackView(alignment: .fill, distribution: .equalCentering, spacing: 0)
        mainStackView.addArrangedSubview(prefixLabel)
        mainStackView.addArrangedSubview(starView)
        mainStackView.addArrangedSubview(suffixLabel)
        starView.snp.makeConstraints { (maker) in
            maker.leftSpace(prefixLabel).offset(0)
        }
        suffixLabel.snp.makeConstraints { (maker) in
            maker.leftSpace(starView).offset(5)
        }
        
        self.addSubview(mainStackView)
        mainStackView.edgesToView()
    }
    override var intrinsicContentSize: CGSize {
        var width = starView.intrinsicContentSize.width
        let height = starView.intrinsicContentSize.height
        if prefixLabel.text?.length ?? -1 > 0 {
            width += prefixLabel.intrinsicContentSize.width
        }
        if suffixLabel.text?.length ?? -1 > 0 {
            width += 5 + suffixLabel.intrinsicContentSize.width
        }
        return CGSize(width: width, height: height)
    }
}
