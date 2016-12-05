//
//  HeaderViewProtocol.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

protocol HeaderViewProtocol:TransitionProtocol {
    associatedtype HeaderViewType:BaseTableViewHeaderView
    var headerView:HeaderViewType {get set}
    // MARK: - 调用下面方法可以添加transitionVC到本控制器，并且设置headerView
    func addTransitionVCWithHeaderView(edgesToFill:Bool, hasSegmentControl:Bool)
}
extension HeaderViewProtocol where Self:BaseViewController {
    
    // MARK: transitionVC
    func addTransitionVCWithHeaderView(edgesToFill:Bool = false, hasSegmentControl:Bool = false) {
        self.addTransitionVC(edgesToFill: edgesToFill)
        self.transitionVC.headerView = self.headerView
        if hasSegmentControl {
            self.configSegmentedControlToVC(segmentedControl: self.headerView.segmentedControl) {[unowned self] (viewModel,index) in
                if let viewModel = viewModel {
                    let model = self.headerView.segmentedControl.modelArray[index]
                    viewModel.listTitle = model.title                    
                }
            }
        }else {
            self.updateTransitionChildVC(segmentedControl: nil)
        }
    }
    func configTransitionVC(edgesToFill: Bool) {
        
    }
}
