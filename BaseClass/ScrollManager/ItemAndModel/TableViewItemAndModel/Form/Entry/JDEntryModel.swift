//
//  JDEntryModel.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/2.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift



class JDEntryModel: JDFormModel {
    
    convenience init(image:UIImage? = nil,title:String? = nil,entrys:[(String?,String?)] = [(nil,nil)],texts:[String?] = [nil]) {
        self.init(image: image, title: title)
        self.entrys = entrys.map({ (element) -> (Variable<String?>,Variable<String?>) in
            return (Variable(element.0),Variable(element.1))
        })
        var texts = texts
        while texts.count != self.entrys.count {
            if texts.count < self.entrys.count {
                texts.append(nil)
            }else {
                texts.removeLast()
            }
        }
        self.texts = texts.map({ (element) -> Variable<String?> in
            return Variable(element)
        })
    }
    
    var entrys:[(Variable<String?>,Variable<String?>)] = [(Variable(nil),Variable(nil))]
    var texts:[Variable<String?>] = [Variable(nil)]
    
    convenience init(image:UIImage? = nil,title:String? = nil,text:String? = "",placeholder:String? = "") {
        self.init(image: image, title: title)
        self.entrys = [(Variable(nil),Variable(placeholder))]
        self.texts = [Variable(text)]
    }
    var text:String? {
        get {
            return self.texts.first?.value
        }
        set {
            self.texts.first?.value = newValue
        }
    }
    var placeholder:String? {
        get {
            return self.entrys.first?.1.value
        }
        set {
            self.entrys.first?.1.value = newValue
        }
    }
}
extension JDEntryModel:CatchParamsProtocol,CheckParamsProtocol {
    func catchParams() -> [String : Any] {
        var params = [String:Any]()
        params[key] = text
        return params
    }
    func checkParams() -> Bool {
        guard let text = text, text.length > 0 else {
            HUD.showPrompt(self.placeholder ?? "请把数据填写完整")
            return false
        }
        return true
    }
}
