//
//  AddChildScrollProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/22.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol AddChildScrollProtocol:AssociatedObjectProtocol {
    associatedtype ChildScrollVCType:ScrollViewController
    associatedtype MainVCType:UIViewController
    associatedtype TitleViewType:UIView
    associatedtype BottomType:UIView
    // MARK: - 实现下面方法创建控制器
    func createScrollVC(index:Int) -> ChildScrollVCType
    // MARK: - 添加主控制器
    var mainVC:MainVCType! {get set}
    func createMainVC() -> MainVCType
    // MARK: - 调用该方法可添加子控制器到本控制器中
    func addChildScrollVC(edgesToFill:Bool)
    // MARK: - 
    func getTitleView() -> TitleViewType?
    func getBottomView() -> BottomType?
    func installTitleView(edgesToFill:Bool)
    func installBottomView(edgesToFill:Bool)
}

private var MainVCKey:UInt8 = 0
extension AddChildScrollProtocol where Self:BaseViewController {
    var mainVC:MainVCType! {
        get {
            return associatedObject(&MainVCKey)
        }
        set {
            setAssociatedObject(&MainVCKey, newValue)
        }
    }
    // MARK: -
    func addChildScrollVC(edgesToFill:Bool = false) {
        if let mainVC = self.mainVC {
            mainVC.view.removeFromSuperview()
            mainVC.removeFromParentViewController()
        }
        self.installTitleView(edgesToFill:edgesToFill)
        self.installBottomView(edgesToFill:edgesToFill)
        self.mainVC = createMainVC()
        updateMainView(edgesToFill)
    }
    func createMainVC() -> ChildScrollVCType {
        return createScrollVC(index: 0)
    }
    
    fileprivate func updateMainView(_ edgesToFill:Bool = false) {
        guard let mainVC = self.mainVC else {
            return
        }
        self.addChildViewController(mainVC)
        self.view.insertSubview(mainVC.view, at: 0)
        mainVC.view.snp.remakeConstraints({ (maker) in
            maker.left.centerX.equalToSuperview()
            /// ZJaDe: titleView
            if let titleView = self.getTitleView() {
                maker.topSpace(titleView)
            }else {
                if edgesToFill {
                    maker.top.equalToSuperview()
                }else {
                    maker.topSpaceToVC(self)
                }
            }
            /// ZJaDe: bottomView
            if let bottomView = self.getBottomView() {
                maker.bottomSpace(bottomView)
            }else {
                if edgesToFill {
                    maker.bottom.equalToSuperview()
                }else {
                    maker.bottomSpaceToVC(self)
                }
            }
        })
    }
    // MARK: - TitleView BottomView
    func getTitleView() -> UIView? {
        return nil
    }
    func getBottomView() -> UIView? {
        return nil
    }
    func installTitleView(edgesToFill:Bool = false) {
        if let titleView = self.getTitleView() {
            if titleView.superview == nil {
                self.view.addSubview(titleView)
            }
            titleView.snp.makeConstraints({ (maker) in
                maker.left.centerX.equalToSuperview()
                if edgesToFill {
                    maker.top.equalToSuperview()
                }else {
                    maker.topSpaceToVC(self)
                }
            })
        }
        updateMainView(edgesToFill)
    }
    func installBottomView(edgesToFill:Bool = false) {
        if let bottomView = self.getBottomView() {
            if bottomView.superview == nil {
                self.view.addSubview(bottomView)
            }
            bottomView.snp.makeConstraints({ (maker) in
                maker.left.centerX.equalToSuperview()
                if edgesToFill {
                    maker.bottom.equalToSuperview()
                }else {
                    maker.bottomSpaceToVC(self)
                }
            })
        }
        updateMainView(edgesToFill)
    }
    
}
