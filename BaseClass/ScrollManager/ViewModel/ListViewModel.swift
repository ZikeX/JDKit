//
//  ListViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift

protocol CreateListProtocol:class {
    var listTitle:String? {get set}
    associatedtype ListVCType:ListViewController
    func createBaseListVC() -> ListVCType
}

class ListViewModel: NSObject {
    var index:Int!
    var listTitle: String?
    
    let disposeBag = DisposeBag()
    
    
    override init() {
        super.init()
        self.configInit()
    }
    func configInit() {
        
    }
    // MARK: - selected
    var selectedIndexPaths = [IndexPath]()
    var maxSelectedCount:Int = 0
    
    deinit {
        logDebug("\(type(of:self))->\(self)注销")
    }
}

extension ListViewModel {
    func whenCellSelected(_ indexPath:IndexPath) {
        guard self.maxSelectedCount > 0 else {
            return
        }
        // MARK: - cell
        if let index = self.selectedIndexPaths.index(of: indexPath) {
            self.selectedIndexPaths.remove(at: index)
        }else {
            self.selectedIndexPaths.append(indexPath)
            
        }
    }
}
extension ListViewModel:CreateListProtocol {

    func createBaseListVC() -> ListViewController {
        var listVC:ListViewController?
        if let tableViewModel = self as? TableViewModel {
            listVC = TableViewController(viewModel: tableViewModel)
            listVC!.title = tableViewModel.listTitle
        }else if let collectionViewModel = self as? CollectionViewModel {
            listVC = CollectionViewController(viewModel: collectionViewModel)
            listVC!.title = self.listTitle
        }else {
            fatalError("很明显ViewModel类型不对")
        }
        listVC!.index = index
        return listVC!
    }
}
extension ListViewModel {/// ZJaDe: EmptyDataSet
    // MARK: - 设置EmptyDataSet内容
    func configEmptyDataSetNoData(_ contentView:UIStackView) {
        let label = UILabel(text: "无数据", color: Color.gray, font: Font.h1)
        contentView.addSubview(label)
        label.edgesToView()
    }
    func configEmptyDataSetLoadFailed(_ contentView:UIStackView) {
        
    }
    func configEmptyDataSetLoading(_ contentView:UIStackView) {
        
    }
}
