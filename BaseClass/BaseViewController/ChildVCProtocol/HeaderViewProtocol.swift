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
    
    func addTransitionVCWithHeaderView(edgesToFill:Bool, hasSegmentControl:Bool)
}
extension HeaderViewProtocol where Self:BaseViewController {
    
    // MARK: transitionVC
    func addTransitionVCWithHeaderView(edgesToFill:Bool = false, hasSegmentControl:Bool = false) {
        self.addTransitionVC(edgesToFill: edgesToFill)
        self.transitionVC.headerView = self.headerView
        if hasSegmentControl {
            self.configSegmentedControlToVC(segmentedControl: self.headerView.segmentedControl) { (viewModel,index) in
                let model = self.headerView.segmentedControl.modelArray[index]
                viewModel.listTitle = model.title
            }
        }else {
            self.updateTransitionChildVC(segmentedControl: nil)
        }
    }
    func configTransitionVC(edgesToFill: Bool) {
        
    }
}
