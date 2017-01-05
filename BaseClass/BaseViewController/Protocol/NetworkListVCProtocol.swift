//
//  NetworkListVCProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import MJRefresh

protocol NetworkListVCProtocol:NetworkVCProtocol {
    associatedtype ViewModelType:TableViewModel
    var viewModel:ViewModelType {get}
    var page:Int {get set}
    func resetPageIndex()
    /// ZJaDe: 解析数组
    func parseModelArray(_ modelArray:[TableModel],_ refresh:Bool)
    // ZJaDe: 调用此方法来设置是否可以上拉加载或者是否下拉刷新
    func configRefresh(refreshHeader:Bool,refreshFooter:Bool)
    /// ZJaDe: 调用此方法来下拉刷新
    func refreshDataHeader(_ animated:Bool)
    /// ZJaDe: 调用此方法来上拉加载
    func refreshDataFooter(_ animated:Bool)
    /// ZJaDe:
    func request(refresh:Bool)
}
extension NetworkListVCProtocol {
    private var tableView:TableView {
        return self.viewModel.tableView
    }
    /// ZJaDe: 解析数组
    func parseModelArray(_ modelArray:[TableModel],_ refresh:Bool) {
        self.tableView.mj_header?.endRefreshing()
        if refresh {
            self.resetPageIndex()
        }
        if modelArray.count > 0 {
            self.page += 1
        }else {
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            return
        }
        let viewModel:TableViewModel = self.viewModel
        if refresh {
            viewModel.updateDataSource { (oldData) -> [(TableSection, [TableModel])]? in
                var newData = oldData
                let section:TableSection
                if let last = newData.popLast() {
                    section = last.0
                }else {
                    section = TableSection()
                }
                newData.append((section,modelArray))
                return newData
            }
        }else {
            viewModel.updateDateScouceAppend(modelArray)
        }
    }
    /// ZJaDe: 调用此方法来设置是否可以上拉加载或者是否下拉刷新
    func configRefresh(refreshHeader:Bool = true,refreshFooter:Bool = true) {
        if refreshHeader {
            self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
                self.refreshDataHeader(false)
            })
        }else {
            self.tableView.mj_header = nil
        }
        if refreshFooter {
            self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [unowned self] in
                self.refreshDataHeader(false)
            })
        }else {
            self.tableView.mj_footer = nil
        }
    }
    /// ZJaDe: 调用此方法来下拉刷新
    func refreshDataHeader(_ animated:Bool) {
        if animated {
            self.tableView.mj_header.beginRefreshing()
        }else {
            request(refresh:true)
        }
    }
    /// ZJaDe: 调用此方法来上拉加载
    func refreshDataFooter(_ animated:Bool) {
        if animated {
            self.tableView.mj_footer.beginRefreshing()
        }else {
            request(refresh:false)
        }
    }
}
