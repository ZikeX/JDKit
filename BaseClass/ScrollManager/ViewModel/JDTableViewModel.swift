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
    var listStyle:UITableViewStyle = .grouped
    
    weak var tableView:JDTableView!
    weak var listVC:JDTableViewController?
    override var listTitle:String? {
        didSet {
            self.listVC?.title = self.listTitle
        }
    }
    
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

    }
    func getLocalSectionModels() -> [(JDTableSection, [JDTableModel])]? {
        return nil
    }
    // MARK: - eachModel
    @discardableResult
    func eachModel(_ closure:(JDTableModel)->(Bool)) -> Bool {
        for sectionModel in dataArray {
            for model in sectionModel.1 {
                if closure(model) == false {
                    return false
                }
            }
        }
        return true
    }
    // MARK: - checkAndCatchParams
    
    func catchAllParams() -> [String:Any] {
        func catchModelParams(_ model:JDTableModel) -> [String:Any]? {
            if model.catchParamsClosure != nil {
                return model.catchParamsClosure!()
            }else if let model = model as? CatchParamsProtocol,model.key.length > 0 {
                return model.catchParams()
            }else {
                return nil
            }
        }
        var params = [String:Any]()
        self.eachModel { (model) -> (Bool) in
            if let modelParams = catchModelParams(model) {
                modelParams.forEach({ (key: String, value: Any) in
                    params[key] = value
                })
            }
            return true
        }
        return params
    }
    func checkAllParams() -> Bool {
        func checkModelParams(_ model:JDTableModel) -> Bool {
            if model.catchParamsClosure != nil {
                return model.checkParamsClosure!()
            }else if let model = model as? CheckParamsProtocol,model.checkParams() == false {
                return false
            }
            return true
        }
        return self.eachModel { (model) -> (Bool) in
            return checkModelParams(model)
        }
    }
    func checkAndCatchParams() -> [String:Any]? {
        if checkAllParams() {
            return catchAllParams()
        }else {
            return nil
        }
    }
    // MARK: - CellSelectedState
    override func whenCellSelected(_ indexPath:IndexPath) {
        guard self.maxSelectedCount > 0 else {
            return
        }
        super.whenCellSelected(indexPath)
        if self.selectedIndexPaths.contains(indexPath) {
            self.updateSelectedState(true, indexPath: indexPath)
            while self.selectedIndexPaths.count > maxSelectedCount {
                let firstIndexPath = self.selectedIndexPaths.removeFirst()
                self.updateSelectedState(false, indexPath: firstIndexPath)
            }
        }else {
            self.updateSelectedState(false, indexPath: indexPath)
        }
    }
    private func updateSelectedState(_ selected:Bool,indexPath:IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? JDTableCell {
            updateCellSelectedState(selected, cell: cell)
        }
        self.getModel(indexPath)?.isSelected = selected
    }
    func updateCellSelectedState(_ selected:Bool,cell:JDTableCell) {
        cell.accessoryView = selected ? ImageView(image: R.image.ic_cell_checkmark()) : nil
    }
}
extension JDTableViewModel {
    // MARK: - 自定义代理
    func didSelectRowAt(indexPath:IndexPath,model:JDTableModel) {
        
    }
}
extension JDTableViewModel:UITableViewDelegate {
    final func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.tableView.endEditing(true)
    }
    func getModel(_ indexPath:IndexPath) -> JDTableModel? {
        guard indexPath.section < rxDataSource.sectionModels.count else {
            return nil
        }
        let sectionModel = rxDataSource[indexPath.section]
        guard indexPath.row < sectionModel.items.count else {
            return nil
        }
        return sectionModel.items[indexPath.row]
    }

    // MARK: - display
    final func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableCell {
            let model = getModel(indexPath)!
            cell.itemWillAppear(model)
            if self.maxSelectedCount > 0 {
                if model.isSelected {
                    self.selectedIndexPaths.append(indexPath)
                }else if let index = self.selectedIndexPaths.index(of: indexPath){
                    self.selectedIndexPaths.remove(at: index)
                }
                updateCellSelectedState(model.isSelected, cell: cell)
            }
        }
    }
    final func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? JDTableCell {
            let model = getModel(indexPath)
            cell.itemDidDisappear(model)
        }
    }
    // MARK: - didSelectRow
    final func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let model = getModel(indexPath)!
        return model.enabled ?? true
    }
    final func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.autoDeselectRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        whenCellSelected(indexPath)
        
        let model = getModel(indexPath)!
        self.didSelectRowAt(indexPath: indexPath, model: model)
    }
    // MARK: - cellHeight
    final func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = getModel(indexPath)!
        return model.cellHeight
    }
    // MARK: - headerView
    final func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            let headerView = sectionModel.headerView
            if let headerColor = sectionModel.headerViewColor  {
                headerView.backgroundView = UIView()
                headerView.backgroundView?.backgroundColor = headerColor
                
            }
            return headerView
        }else {
            return nil
        }
    }
    final func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        /// ZJaDe: 该方法暂时无用
        
    }
    final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            return sectionModel.headerViewHeight
        }else {
            return 0
        }
    }
    // MARK: - footerView
    final func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            let footerView = sectionModel.footerView
            if let footerColor = sectionModel.footerViewColor {
                footerView.backgroundView = UIView()
                footerView.backgroundView?.backgroundColor = footerColor
            }
            return footerView
        }else {
            return nil
        }
    }
    final func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        /// ZJaDe: 该方法暂时无用
        
    }
    final func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if rxDataSource.sectionModels.count > section {
            let sectionModel = rxDataSource[section].model
            return sectionModel.footerViewHeight
        }else {
            return 0
        }
    }
}
