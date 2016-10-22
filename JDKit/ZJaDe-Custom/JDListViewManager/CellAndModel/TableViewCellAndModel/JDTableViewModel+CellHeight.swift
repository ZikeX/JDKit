//
//  JDTableViewModel-CellHeight.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/7.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

extension JDTableViewModel { //创建cell
    func createCellWithTableView(_ tableView:UITableView,indexPath:IndexPath? = nil) -> UITableViewCell? {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            if isNibCell {
                tableView.register(UINib(nibName:cellName,bundle:nil), forCellReuseIdentifier: reuseIdentifier)
            }else {
                tableView.register(NSClassFromString(cellClassName), forCellReuseIdentifier: reuseIdentifier)
            }
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        }
        return cell
    }
}
extension JDTableViewModel { //计算高度
    func calculateCellHeight(_ tableView:UITableView) -> CGFloat {
        if autoAdjustHeight && !cellHeightIsCanUse {
            let tableViewWidth = tableView.frame.width
            if tableViewWidth <= 0 {
                return 44
            }
            /*************** 获取tempCell，并赋值 ***************/
            let tempCell = getTempCell(tableView)
            tempCell.prepareForReuse()
            bindingDataAndConstraint(tempCell)
            /*************** Frame计算jdContentView的高度 ***************/
            let contentWidth = getContentViewWidth(tableView, cell: tempCell)
            if let jdContentViewHeight = frameLayoutJDContentViewHeight(tableView,tempCell: tempCell,contentWidth: contentWidth) {
                self.jdContentViewHeight = jdContentViewHeight
                makeCellHeightCanUse()
                logDebug("Frame计算出cell->高度：\(cellHeight)")
            }else {
                /*************** AutoLayout计算Cell的高度 ***************/
                cellHeight = autoLayoutCellHeight(tableView, tempCell: tempCell, contentWidth: contentWidth)
                makeCellHeightCanUse()
                logDebug("AutoLayout计算出cell->高度：\(cellHeight)")
            }
            theEndLayoutClosure?(self.jdContentViewHeight)
        }
        return cellHeight
    }
}
extension JDTableViewModel {
    /*************** 计算JDContentView高度 ***************/
    func frameLayoutJDContentViewHeight(_ tableView:UITableView,tempCell:JDTableViewCell,contentWidth:CGFloat) -> CGFloat? {
        let jdContentViewWidth = contentWidth - spaceEdges.left - spaceEdges.right
        let jdContentViewHeight = tempCell.calculateJDContentViewHeight(jdContentViewWidth,elementModel: self)
        if jdContentViewHeight > 0 {
            return jdContentViewHeight
        }else {
            return nil
        }
    }
    func autoLayoutCellHeight(_ tableView:UITableView,tempCell:JDTableViewCell,contentWidth:CGFloat) -> CGFloat {
        tempCell.contentView.snp.makeConstraints { (maker) in
            maker.width.equalTo(contentWidth)
        }
        let cellHeight = tempCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        tempCell.contentView.snp.removeConstraints()
        
        return cellHeight
    }
}
extension JDTableViewModel {
    var cellHeight:CGFloat {
        get {
            return (cellContentHeight ?? 44) + separatorFillHeight
        }
        set {
            cellContentHeight = newValue - separatorFillHeight
        }
    }
    var jdContentViewHeight:CGFloat {
        get {
            return (cellContentHeight ?? 44) - contentViewVerticalEdge
        }
        set {
            cellContentHeight = newValue + contentViewVerticalEdge
        }
    }
    var contentViewVerticalEdge:CGFloat {
        return spaceEdges.top + spaceEdges.bottom
    }
    var separatorFillHeight:CGFloat {
        return separatorInset.top + separatorInset.bottom + lineHeight
    }
    
    func getContentViewWidth(_ tableView:UITableView,cell:JDTableViewCell) -> CGFloat {
        var contentViewWidth = tableView.frame.width
        if cell.accessoryView != nil {
            contentViewWidth -= 16 + cell.accessoryView!.frame.width
        }else {
            switch cell.accessoryType {
            case .none:
                contentViewWidth -= 0
            case .disclosureIndicator:
                contentViewWidth -= 34
            case .detailDisclosureButton:
                contentViewWidth -= 68
            case .checkmark:
                contentViewWidth -= 40
            case .detailButton:
                contentViewWidth -= 48
            }
        }
        return contentViewWidth
    }
}
private var tempCells = [String:JDTableViewCell]()
extension JDTableViewModel { //tempCell
    func getTempCell(_ tableView:UITableView) -> JDTableViewCell  {
        if let tempCell = tempCells[reuseIdentifier] {
            return tempCell
        }else {
            let tempCell = createCellWithTableView(tableView) as! JDTableViewCell
            tempCell.isTempCell = true
            tempCells[reuseIdentifier] = tempCell
            return tempCell
        }
    }
    func bindingDataAndConstraint(_ tempCell:JDTableViewCell) {
        tempCell.cellDidLoad(self)
        tempCell.configCellWithElement(self)
        tempCell.cellUpdateConstraints(self)
    }
}