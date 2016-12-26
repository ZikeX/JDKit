//
//  CreateListProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/10.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
protocol CreateChildListVCProtocol:class {
    associatedtype ChildListViewModelType:ListViewModel
    func createListViewModel(index:Int) -> ChildListViewModelType
}
extension CreateChildListVCProtocol where Self:BaseViewController {
    func createScrollVC(index:Int) -> ListViewController {
        let viewModel = createListViewModel(index: index)
        viewModel.index = index
        return viewModel.createBaseListVC()
    }
}
// MARK: - 
protocol AddChildListProtocol:AddChildScrollProtocol,CreateChildListVCProtocol {}
protocol ListPageProtocol:PageProtocol,CreateChildListVCProtocol {}
protocol ListSegmentProtocol:SegmentProtocol,CreateChildListVCProtocol {}
protocol ListHeaderViewProtocol:HeaderViewProtocol,CreateChildListVCProtocol {}
protocol ListHeaderViewWithSegmentProtocol:HeaderViewWithSegmentProtocol,CreateChildListVCProtocol {}
