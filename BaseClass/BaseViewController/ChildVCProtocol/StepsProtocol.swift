//
//  StepsProtocolswift.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/17.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

protocol StepsProtocol:class {
    associatedtype StepsVCType:UIViewController
    
    var allStepsVC:[Int:StepsVCType] {get set}
    var maxStepsCount:Int {get set}
    var stepsIndex:Int {get set}
    func createStepsVC(stepsIndex:Int) -> StepsVCType
    
    var currentStepsVC:StepsVCType {get}
    var firstVC:StepsVCType {get}
    
    func loadChildVC()
    func scrollToNextVC()
}
extension StepsProtocol where Self:UIViewController {
    var firstVC:StepsVCType {
        return self.getStepsVC(stepsIndex: 0)
    }
    var currentStepsVC:StepsVCType {
        return self.allStepsVC[self.stepsIndex]!
    }
    
    func loadChildVC() {
        self.addChildViewController(self.firstVC)
        self.view.addSubview(self.firstVC.view)
        self.firstVC.view.snp.makeConstraints { (maker) in
            maker.topSpaceToVC(self)
            maker.left.bottom.width.equalToSuperview()
        }
        self.navigationItem.title = self.firstVC.title
    }
    func scrollToNextVC() {
        let nextIndex = self.stepsIndex + 1
        guard nextIndex < self.maxStepsCount else {
            return
        }
        let newStepsVC = self.getStepsVC(stepsIndex: nextIndex)
        self.transitionTo(nextIndex, newStepsVC)
    }
    func resetCurrentVC() {
        let newStepsVC = self.createStepsVC(stepsIndex: self.stepsIndex)
        self.transitionTo(self.stepsIndex, newStepsVC)
    }
    func transitionTo(_ nextIndex:Int, _ newStepsVC:StepsVCType) {
        self.addChildViewController(newStepsVC)
        self.view.addSubview(newStepsVC.view)
        newStepsVC.view.snp.makeConstraints { (maker) in
            maker.topSpaceToVC(self)
            maker.bottom.width.equalToSuperview()
            maker.left.equalToSuperview().offset(jd.screenWidth)
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        UIView.spring(duration: 0.75, animations: {
            self.currentStepsVC.view.snp.updateConstraints { (maker) in
                maker.left.equalToSuperview().offset(-jd.screenWidth)
            }
            newStepsVC.view.snp.updateConstraints({ (maker) in
                maker.left.equalToSuperview()
            })
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            self.currentStepsVC.view.removeFromSuperview()
            self.currentStepsVC.removeFromParentViewController()
            self.stepsIndex = nextIndex
            self.allStepsVC[self.stepsIndex] = newStepsVC
            self.navigationItem.title = self.currentStepsVC.title
        })
    }
    func getStepsVC(stepsIndex:Int) -> StepsVCType {
        let stepVC:StepsVCType
        if let existing = self.allStepsVC[stepsIndex] {
            stepVC = existing
        }else {
            stepVC = self.createStepsVC(stepsIndex: stepsIndex)
            self.allStepsVC[stepsIndex] = stepVC
        }
        return stepVC
    }
}
