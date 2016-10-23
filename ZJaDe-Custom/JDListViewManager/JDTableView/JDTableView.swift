//
//  JDTableView.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDTableView: UITableView {
    let disposeBag = DisposeBag()
    
    let reloadDataSource = RxTableViewSectionedReloadDataSource<SectionModel<JDSection,JDTableViewModel>>()
    var dataArray = Variable([SectionModel<JDSection,JDTableViewModel>]())
    var page = 1
    
    /// ZJaDe: - 自动取消选择
    var autoDeselectRow = true
    // MARK: -
    override init(frame: CGRect = CGRect(), style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.configCellInit()
    }
    convenience init() {
        self.init(frame:CGRect(),style: .plain)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configCellInit()
    }
    func configCellInit() {
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
            if let cell = cell as? JDTableViewCell {
                cell.cellDidLoad(model)
                _ = model.calculateCellHeight(tableView)
            }
            return cell
        }
        self.dataArray.asObservable().bindTo(self.rx.items(dataSource: reloadDataSource)).addDisposableTo(disposeBag)
        
        _ = self.rx.willDisplayCell.subscribe { (event) in
            guard let element = event.element else {
                return
            }
            if let cell = element.cell as? JDTableViewCell,
                let model = try? self.rx.model(element.indexPath) as JDTableViewModel {
                cell.cellWillAppear(model)
            }
        }
        _ = self.rx.didEndDisplayingCell.subscribe { (event) in
            guard let element = event.element else {
                return
            }
            if let cell = element.cell as? JDTableViewCell,
                let model = try? self.rx.model(element.indexPath) as JDTableViewModel {
                cell.cellDidDisappear(model)
            }
        }
    }
}
extension JDTableView:UITableViewDelegate {
    func configDelegate() {
        self.rx.setDelegate(self).addDisposableTo(disposeBag)
        self.rx.itemSelected.subscribe { (event) in
            if let indexPath = event.element, self.autoDeselectRow {
                self.deselectRow(at: indexPath, animated: true)
            }
            }.addDisposableTo(disposeBag)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let model = try? tableView.rx.model(indexPath) as JDTableViewModel {
            model.perform(#selector(JDTableViewModel.calculateCellHeight(_:)), on: Thread.main, with: self, waitUntilDone: false,modes:[RunLoopMode.defaultRunLoopMode.rawValue])
            return model.cellHeight
        }
        return 33.33333
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = reloadDataSource.sectionAtIndex(section).model
        return sectionModel.headerView
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionModel = reloadDataSource.sectionAtIndex(section).model
        return sectionModel.footerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = reloadDataSource.sectionAtIndex(section).model
        return sectionModel.headerViewHeight
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionModel = reloadDataSource.sectionAtIndex(section).model
        return sectionModel.footerViewHeight
    }
}
