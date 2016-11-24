//
//  SubViewProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/24.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
protocol SubViewProtocol:ExtensionPropertysProtocol {
    func createIfNotExisting(tag:Int,_ closure:(UIView)->UIView) -> UIView
    func createIfNotExisting(identifier:String,_ closure:(UIView)->UIView) -> UIView
}
extension SubViewProtocol where Self:UIView {
    @discardableResult
    func createIfNotExisting(tag:Int,_ closure:(UIView)->UIView) -> UIView {
        if let view = self.viewWithTag(tag) {
            return view
        }else {
            let view = closure(self)
            view.tag = tag
            if view.superview == nil {
                if let stackView = self as? UIStackView {
                    stackView.addArrangedSubview(view)
                }else {
                    self.addSubview(view)
                }
            }
            return view
        }
    }
    @discardableResult
    func createIfNotExisting(identifier:String,_ closure:(UIView)->UIView) -> UIView {
        if let view = self.extenPropertys[identifier] as? UIView {
            return view
        }else {
            let view = closure(self)
            self.extenPropertys[identifier] = view
            return view
        }
    }
}
extension UIView:SubViewProtocol {
}

















