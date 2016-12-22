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
}
extension JDEntryModel:CatchParamsProtocol {
    func catchParms() -> [String : Any] {
        var params = [String:Any]()
        params[key] = texts.first?.value
        return params
    }
}
