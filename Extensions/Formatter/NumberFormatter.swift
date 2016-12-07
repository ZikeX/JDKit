//
//  NumberFormatter.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/18.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class PriceFormatter:NumberFormatter {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init() {
        super.init()
        self.numberStyle = .currencyAccounting
    }
    func string(from price: Price) -> String {
        return self.string(from: NSNumber(value: price.value)) ?? "金额出错"
    }
    
    func price(from string: String) -> Price? {
        if let number = self.number(from: string) {
            return Price(number.doubleValue)
        }else {
            return nil
        }
    }
}
class ScoreFormatter:NumberFormatter {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(_ increment:ScoreValue = 0.1) {
        super.init()
        self.numberStyle = .decimal
        self.roundingIncrement = NSNumber(value: increment)
    }
    func string(from score: Score) -> String {
        return self.string(from: NSNumber(value: score.value)) ?? "分数出错"
    }
    
    func score(from string: String) -> Score? {
        if let number = self.number(from: string) {
            return Score(number.doubleValue)
        }else {
            return nil
        }
    }
}
