//
//  JDTableView.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTableView: UITableView {
    let disposeBag = DisposeBag()
    
    let reloadDataSource = RxTableViewSectionedReloadDataSource<SectionModel<JDTableViewSection,JDTableViewModel>>()
    var dataArray = Variable([SectionModel<JDTableViewSection,JDTableViewModel>]())
    var page = 1
    
    /// ZJaDe: - 自动取消选择
    var autoDeselectRow = true
    // MARK: -
    convenience init() {
        self.init(frame:CGRect(),style: .plain)
    }
    override init(frame: CGRect = CGRect(), style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configInit()
    }
    func configInit() {
        self.separatorStyle = .none
        configDataSource()
        configDelegate()
//        let items = reloadDataSource.sectionModels.flatMap {$0.items}
//        calculateCellHeights(modelArr: items)
    }
}
extension JDTableView {
    func configDataSource() {
        reloadDataSource.configureCell = {(dataSource, tableView, indexPath, model) in
            let cell =  model.createCellWithTableView(tableView, indexPath: indexPath)!
            _ = model.calculateCellHeight(tableView)
            return cell
        }
        self.dataArray.asObservable().bindTo(self.rx.items(dataSource: reloadDataSource)).addDisposableTo(disposeBag)
    }
}
extension JDTableView:UITableViewDelegate {
    func configDelegate() {
        self.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.endEditing(true)
    }
    // MARK: - display
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableViewCell {
            let model = reloadDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableViewCell {
            let model = reloadDataSource[indexPath]
            cell.cellDidDisappear(model)
        }
    }
    // MARK: - didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.autoDeselectRow {
            self.deselectRow(at: indexPath, animated: true)
        }
    }
    // MARK: - cellHeight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = reloadDataSource[indexPath]
        model.perform(#selector(JDTableViewModel.calculateCellHeight(_:)), on: Thread.main, with: self, waitUntilDone: false,modes:[RunLoopMode.defaultRunLoopMode.rawValue])
        return model.cellHeight
    }
    // MARK: - headerView And footerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = reloadDataSource[section].model
        //let sectionModel = reloadDataSource.sectionAtIndex(section).model
        return sectionModel.headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionModel = reloadDataSource[section].model
        return sectionModel.footerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = reloadDataSource[section].model
        return sectionModel.headerViewHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionModel = reloadDataSource[section].model
        return sectionModel.footerViewHeight
    }
}
