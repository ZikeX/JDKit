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
    
    var sectionModels = Variable([AnimatableSectionModel<JDTableViewSection,JDTableViewModel>]())
    let rxDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<JDTableViewSection,JDTableViewModel>>()
    public var dataArray = [(JDTableViewSection,[JDTableViewModel])]()
    var page = 1
    
    /// ZJaDe: - 自动取消选择
    var autoDeselectRow = true
    // MARK: -
    override init(frame: CGRect = CGRect(), style: UITableViewStyle = .plain) {
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
    func getLocalSectionModels() -> [(JDTableViewSection, [JDTableViewModel])]? {
        return nil
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
            let model = rxDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableViewCell {
            let model = rxDataSource[indexPath]
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
        self.perform(#selector(calculateCellHeight), on: Thread.main, with: indexPath, waitUntilDone: false,modes:[RunLoopMode.defaultRunLoopMode.rawValue])
        let model = rxDataSource[indexPath]
        return model.cellHeight
    }
    func calculateCellHeight(indexPath:IndexPath) {
        let model = rxDataSource[indexPath]
        _ = model.calculateCellHeight(self)
    }
    // MARK: - headerView And footerView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            return sectionModel.headerView
        }else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            return sectionModel.footerView
        }else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            return sectionModel.headerViewHeight
        }else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            return sectionModel.footerViewHeight
        }else {
            return 0
        }
    }
}
