//
//  JDTableView-Web.swift
//  JDTableViewManagerSwift
//
//  Created by 茶古电子商务 on 16/9/14.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import MJRefresh

extension JDTableView {
    func configRequest(refresh:Bool) {
    }
    func parseModelArray(_ modelArray:[JDTableViewModel],page:Int) {
        self.mj_header.endRefreshing()
        if modelArray.count > 0 {
            self.page += 1
        }else {
            self.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        var items = dataArray.value.first?.items ?? [JDTableViewModel]()
        items.append(contentsOf: modelArray)
        dataArray.value = [SectionModel(model: JDSection(), items: items)]
    }
}
extension JDTableView {// mj_header, mj_footer
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
    func refreshDataHeader(_ animated:Bool) {
        if animated {
            self.mj_header.beginRefreshing()
        }else {
            configRequest(refresh:true)
        }
    }
    func refreshDataFooter(_ animated:Bool) {
        if animated {
            self.mj_footer.beginRefreshing()
        }else {
            configRequest(refresh:false)
        }
    }
}
