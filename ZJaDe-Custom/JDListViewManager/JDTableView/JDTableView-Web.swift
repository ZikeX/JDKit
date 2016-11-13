//
//  JDTableView-Web.swift
//  JDTableViewManagerSwift
//
//  Created by 茶古电子商务 on 16/9/14.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import MJRefresh

extension JDTableView {
    open func configRequest(refresh:Bool) {
    }
    func parseModelArray(_ modelArray:[JDTableViewModel]) {
        self.mj_header.endRefreshing()
        if modelArray.count > 0 {
            self.page += 1
        }else {
            self.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        self.updateDataSource { (oldData) -> [(JDTableViewSection, [JDTableViewModel])]? in
            let section = oldData.last?.0 ?? JDTableViewSection()
            let models = (oldData.last?.1 ?? [JDTableViewModel]()) + modelArray
            return [(section,models)]
        }
    }
}
extension JDTableView {// mj_header, mj_footer
    /// ZJaDe: 调用此方法来设置是否可以上拉加载或者是否下拉刷新
    func configRefresh(refreshHeader:Bool = true,refreshFooter:Bool = true) {
        if refreshHeader {
            self.mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
                self.refreshDataHeader(false)
                })
        }else {
            self.mj_header = nil
        }
        if refreshFooter {
            self.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [unowned self] in
                self.refreshDataHeader(false)
                })
        }else {
            self.mj_footer = nil
        }
    }
    /// ZJaDe: 调用此方法来下拉刷新
    func refreshDataHeader(_ animated:Bool) {
        if animated {
            self.mj_header.beginRefreshing()
        }else {
            configRequest(refresh:true)
        }
    }
    /// ZJaDe: 调用此方法来上拉加载
    func refreshDataFooter(_ animated:Bool) {
        if animated {
            self.mj_footer.beginRefreshing()
        }else {
            configRequest(refresh:false)
        }
    }
}
