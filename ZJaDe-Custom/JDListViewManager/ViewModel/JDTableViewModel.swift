//
//  JDTableViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

import RxSwift
class JDTableViewModel: JDListViewModel {
    var listStyle:UITableViewStyle = .plain
    
    weak var tableView:JDTableView!
    weak var listVC:JDTableViewController?
    
    
    var sectionModelsChanged = PublishSubject<[AnimatableSectionModel<JDTableSection,JDTableModel>]>()
    let rxDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<JDTableSection,JDTableModel>>()
    public var dataArray = [(JDTableSection,[JDTableModel])]()
    var page = 1
    
    /// ZJaDe: - 自动取消选择
    var autoDeselectRow = true
    
    // MARK: -
    func resetInit() {/// ZJaDe: 当self被设置进入tableView之后调用
        self.configTableView(tableView)
        self.loadLocalSectionModels()
        tableView.emptyDataSetView.configEmptyDataSetData {[unowned self] (state, contentView) in
            switch state {
            case .loading:
                self.configEmptyDataSetLoading(contentView)
            case .loadFailed:
                self.configEmptyDataSetLoadFailed(contentView)
            case .loaded:
                self.configEmptyDataSetNoData(contentView)
            }
        }
    }
    func configTableView(_ tableView:JDTableView) {
        tableView.rx.modelSelected(JDTableModel.self).subscribe(onNext:{[unowned self] (model) in
            self.whenModelSelected(model)
        }).addDisposableTo(disposeBag)
    }
    func getLocalSectionModels() -> [(JDTableSection, [JDTableModel])]? {
        return nil
    }
    // MARK: - selected
    var selectedModels = [JDTableModel]()
    var selectedIndexPaths = [IndexPath]()
    var maxSelectedCount:Int?
}
extension JDTableViewModel {
    func whenCellSelected(_ indexPath:IndexPath) {
        guard let maxSelectedCount = maxSelectedCount,maxSelectedCount > 0 else {
            return
        }
        if !self.selectedIndexPaths.contains(indexPath) {
            self.selectedIndexPaths.append(indexPath)
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = ImageView(image: R.image.ic_cell_checkmark())
        while self.selectedIndexPaths.count > maxSelectedCount {
            let firstIndexPath = self.selectedIndexPaths.removeFirst()
            let cell = tableView.cellForRow(at: firstIndexPath)
            cell?.accessoryView = nil
        }
    }
    func whenModelSelected(_ model:JDTableModel) {
        guard let maxSelectedCount = maxSelectedCount,maxSelectedCount > 0 else {
            return
        }
        if !self.selectedModels.contains(model) {
            self.selectedModels.append(model)
        }
        model.isSelected = true
        while self.selectedModels.count > maxSelectedCount {
            let firstModel = self.selectedModels.removeFirst()
            firstModel.isSelected = false
        }
    }
}
extension JDTableViewModel:UITableViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tableView.endEditing(true)
    }
    // MARK: - display
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableCell {
            let model = rxDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableCell {
            var model:JDTableModel? = nil
            if rxDataSource.sectionModels.count > indexPath.section {
                let models = rxDataSource.sectionModels[indexPath.section].items
                if models.count > indexPath.row {
                    model = models[indexPath.row]
                }
            }
            cell.cellDidDisappear(model)
        }
    }
    // MARK: - didSelectRow
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.autoDeselectRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        whenCellSelected(indexPath)
    }
    // MARK: - cellHeight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = rxDataSource[indexPath]
        return model.cellHeight
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
