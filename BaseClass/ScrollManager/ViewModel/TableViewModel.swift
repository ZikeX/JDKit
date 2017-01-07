//
//  TableViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift

class TableViewModel: ListViewModel {
    var listStyle:UITableViewStyle = .grouped
    
    weak var tableView:TableView!
    weak var listVC:TableViewController?
    override var listTitle:String? {
        didSet {
            self.listVC?.title = self.listTitle
        }
    }
    
    var sectionModelsChanged = PublishSubject<[AnimatableSectionModel<TableSection,TableModel>]>()
    let rxDataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<TableSection,TableModel>>()
    public var dataArray = [(TableSection,[TableModel])]()
    
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
    func configTableView(_ tableView:TableView) {

    }
    func getLocalSectionModels() -> [(TableSection, [TableModel])]? {
        return nil
    }
    // MARK: - 
    func createTableView() -> TableView {
        let tableView = TableView(viewModel: self)
        self.resetInit()
        return tableView
    }
    // MARK: - eachModel
    @discardableResult
    func eachModel(_ closure:(TableModel)->(Bool)) -> Bool {
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
        func catchModelParams(_ model:TableModel) -> [String:Any]? {
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
        func checkModelParams(_ model:TableModel) -> Bool {
            if model.checkParamsClosure != nil {
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
    func checkCanSelected(_ indexPath:IndexPath) -> Bool {
        return self.maxSelectedCount > 0 || getSection(indexPath.section)?.maxSelectedCount ?? -1 > 0
    }
    override func whenCellSelected(_ indexPath:IndexPath) {
        super.whenCellSelected(indexPath)
        guard checkCanSelected(indexPath) else {
            return
        }
        // MARK: 将选中的indexPath添加到数组
        if let index = self.selectedIndexPaths.index(of: indexPath) {
            self.selectedIndexPaths.remove(at: index)
        }else {
            self.selectedIndexPaths.append(indexPath)
        }
        
        self.getModel(indexPath)!.isSelected = self.selectedIndexPaths.contains(indexPath)
        // MARK: 判断数组是否超出最大数量
        if self.maxSelectedCount > 0 {
            while self.selectedIndexPaths.count > maxSelectedCount {
                let firstIndexPath = self.selectedIndexPaths.removeFirst()
                self.getModel(firstIndexPath)?.isSelected = false
            }
        }else if let section = self.getSection(indexPath.section), section.maxSelectedCount > 0 {
            var selectedIndexPaths = self.selectedIndexPaths.filter{$0.section == indexPath.section}
            while selectedIndexPaths.count > section.maxSelectedCount {
                let firstIndexPath = selectedIndexPaths.removeFirst()
                let index = self.selectedIndexPaths.index(of: firstIndexPath)!
                self.selectedIndexPaths.remove(at: index)
                self.getModel(firstIndexPath)?.isSelected = false
            }
        }
        // MARK: selectedIndexPathsChanged
        selectedIndexPathsChanged.onNext(self.selectedIndexPaths)
        // MARK: 更新视图
        self.tableView.indexPathsForVisibleRows?.forEach({ (indexPath) in
            if let cell = tableView.cellForRow(at: indexPath) as? TableCell {
                if cell.enabled {
                    let selected = self.selectedIndexPaths.contains(indexPath)
                    updateCellSelectedState(selected, cell: cell)
                }
            }
        })
    }
    private func updateSelectedState(_ selected:Bool,indexPath:IndexPath) {
    }
    func updateCellSelectedState(_ selected:Bool,cell:TableCell) {
        cell.accessoryView = ImageView(image: selected ? R.image.ic_选择_勾选() : R.image.ic_选择_未勾选())
    }
}
extension TableViewModel {
    // MARK: - 自定义代理
    func didSelectRowAt(indexPath:IndexPath,model:TableModel) {
        
    }
    func shouldHighlightRowAt(indexPath:IndexPath,model:TableModel) -> Bool {
        return true
    }
}
extension TableViewModel:UITableViewDelegate {
    func getModel(_ indexPath:IndexPath) -> TableModel? {
        guard let sectionModel = getSectionModel(indexPath.section) else {
            return nil
        }
        guard indexPath.row < sectionModel.items.count else {
            return nil
        }
        return sectionModel.items[indexPath.row]
    }
    func getSection(_ section:Int) -> TableSection? {
        return getSectionModel(section)?.model
    }
    func getSectionModel(_ section:Int) -> AnimatableSectionModel<TableSection,TableModel>? {
        guard section < rxDataSource.sectionModels.count else {
            return nil
        }
        return rxDataSource[section]
    }
    // MARK: - display
    final func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableCell {
            let model = getModel(indexPath)!
            cell.itemWillAppear(model)
            if checkCanSelected(indexPath) {
                let modelIndex = self.selectedIndexPaths.index(of: indexPath)
                if model.isSelected && modelIndex == nil {
                    self.selectedIndexPaths.append(indexPath)
                }else if model.isSelected == false, let index = modelIndex {
                    self.selectedIndexPaths.remove(at: index)
                }
                if model.enabled {
                    updateCellSelectedState(model.isSelected, cell:cell)
                }
            }
        }
    }
    final func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? TableCell {
            let model = getModel(indexPath)
            cell.itemDidDisappear(model)
        }
    }
    // MARK: - didSelectRow
    final func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let model = getModel(indexPath)!
        if shouldHighlightRowAt(indexPath: indexPath, model: model) == false {
            return false
        }else {
            return model.enabled
        }
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
        guard let sectionItem = getSection(section) else {
            return nil
        }
        let headerView = sectionItem.headerView
        if let headerColor = sectionItem.headerViewColor  {
            headerView.backgroundView = UIView()
            headerView.backgroundView?.backgroundColor = headerColor
            
        }
        return headerView
    }
    final func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        /// ZJaDe: 该方法暂时无用
        
    }
    final func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let sectionItem = getSection(section) else {
            return 0
        }
        return sectionItem.headerViewHeight
    }
    // MARK: - footerView
    final func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let sectionItem = getSection(section) else {
            return nil
        }
        let footerView = sectionItem.footerView
        if let footerColor = sectionItem.footerViewColor {
            footerView.backgroundView = UIView()
            footerView.backgroundView?.backgroundColor = footerColor
        }
        return footerView
    }
    final func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        /// ZJaDe: 该方法暂时无用
        
    }
    final func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let sectionItem = getSection(section) else {
            return 0
        }
        return sectionItem.footerViewHeight
    }
}
