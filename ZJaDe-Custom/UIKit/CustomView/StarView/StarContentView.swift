//
//  StarContentView.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/16.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class StarContentView: CustomIBView {

    var score:CGFloat = 0 {
        didSet {
            self.suffixLabel.text = "\(score)分"
            self.starView.score = score
        }
    }
    
    lazy var prefixLabel = UILabel(text: "综合:", color: Color.white, font: Font.h4)
    lazy var suffixLabel = UILabel(text: "", color: Color.orange, font: Font.h4)
    lazy var starView:StarRatingLogicView = StarRatingLogicView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStackView = UIStackView(alignment: .fill, distribution: .equalCentering, spacing: 0)
        mainStackView.addArrangedSubview(prefixLabel)
        mainStackView.addArrangedSubview(starView)
        mainStackView.addArrangedSubview(suffixLabel)
        starView.snp.makeConstraints { (maker) in
            maker.leftSpace(prefixLabel).offset(5)
        }
        suffixLabel.snp.makeConstraints { (maker) in
            maker.leftSpace(starView).offset(5)
        }
        
        self.addSubview(mainStackView)
        mainStackView.edgesToView()
    }
}
