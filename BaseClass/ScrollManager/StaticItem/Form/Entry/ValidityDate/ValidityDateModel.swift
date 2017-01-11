//
//  ValidityDateModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 17/1/11.
//  Copyright © 2017年 Z_JaDe. All rights reserved.
//

import UIKit

class ValidityDateModel: JDEntryModel {

}
extension ValidityDateModel {
    override func catchParams() -> [String : Any] {
        fatalError("两个参数手动实现")
    }
    override func checkParams() -> Bool {
        guard let firstText = texts.first?.value,firstText.length > 0 else {
            HUD.showPrompt(self.self.entrys.first?.1.value ?? "请把数据填写完整")
            return false
        }
        guard let secondText = texts.last?.value,secondText.length > 0 else {
            HUD.showPrompt(self.self.entrys.last?.1.value ?? "请把数据填写完整")
            return false
        }
        return true
    }
}
