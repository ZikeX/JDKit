//
//  JDTableModel-CellHeight.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 16/9/7.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

extension JDTableModel {
    /// ZJaDe: 创建cell
    func createCellWithTableView(_ tableView:UITableView,indexPath:IndexPath? = nil) -> UITableViewCell? {
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        if cell == nil {
            if isNibCell {
                tableView.register(UINib(nibName:reuseIdentifier,bundle:nil), forCellReuseIdentifier: reuseIdentifier)
            }else {
                tableView.register(NSClassFromString(cellClassName), forCellReuseIdentifier: reuseIdentifier)
            }
            cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        }
        return cell
    }
    /// ZJaDe: 计算高度
    func calculateCellHeight(_ tableView:UITableView,wait:Bool) {
        if !cellHeightIsCanUse {
            let tableViewWidth = tableView.frame.width
            if tableViewWidth <= 0 {
                return
            }
            /*************** 获取tempCell，并赋值 ***************/
            let tempCell = getTempCell(tableView)
            tempCell.prepareForReuse()
            bindingDataAndConstraint(tempCell)
            /*************** Frame计算jdContentView的高度 ***************/
            let contentWidth = getContentViewWidth(tableView, cell: tempCell)
            if let cellContentHeight = frameLayoutJDContentViewHeight(tableView,tempCell: tempCell,contentWidth: contentWidth) {
                self.cellContentHeight = cellContentHeight
                
                logDebug("\(Thread.current)->Frame计算出cell->高度：\(cellHeight)")
            }else {
                /*************** AutoLayout计算Cell的高度 ***************/
                cellHeight = autoLayoutCellHeight(tableView, tempCell: tempCell, contentWidth: contentWidth)
                
                logDebug("\(Thread.current)->AutoLayout计算出cell->高度：\(cellHeight)")
            }
            tempCell.itemDidDisappear(self)
        }
    }
}

extension JDTableModel {
    /*************** 计算JDContentView高度 ***************/
    fileprivate func frameLayoutJDContentViewHeight(_ tableView:UITableView,tempCell:JDTableCell,contentWidth:CGFloat) -> CGFloat? {
        let jdContentViewWidth = contentWidth - spaceEdges.left - spaceEdges.right
        let jdContentViewHeight = tempCell.calculateJDContentViewHeight(jdContentViewWidth,elementModel: self)
        if jdContentViewHeight > 0 {
            return jdContentViewHeight
        }else {
            return nil
        }
    }
    fileprivate func autoLayoutCellHeight(_ tableView:UITableView,tempCell:JDTableCell,contentWidth:CGFloat) -> CGFloat {
        tempCell.contentView.snp.makeConstraints { (maker) in
            maker.width.equalTo(contentWidth)
        }
        let cellHeight = tempCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        
        tempCell.contentView.snp.removeConstraints()
        
        return cellHeight
    }
}
extension JDTableModel {
    var cellHeight:CGFloat {
        get {
            if self.cellContentHeight == nil {
                return 45.6
            }
            return cellContentHeight! + separatorFillHeight + contentViewVerticalEdge
        }
        set {
            cellContentHeight = newValue - separatorFillHeight - contentViewVerticalEdge
        }
    }
    fileprivate var contentViewVerticalEdge:CGFloat {
        return spaceEdges.top + spaceEdges.bottom
    }
    fileprivate var separatorFillHeight:CGFloat {
        return separatorInset.top + separatorInset.bottom + lineHeight
    }
    
    fileprivate func getContentViewWidth(_ tableView:UITableView,cell:JDTableCell) -> CGFloat {
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
private var tempCells = [String:JDTableCell]()
extension JDTableModel { //tempCell
    fileprivate func getTempCell(_ tableView:UITableView) -> JDTableCell  {
        if let tempCell = tempCells[reuseIdentifier] {
            return tempCell
        }else {
            let tempCell = createCellWithTableView(tableView) as! JDTableCell
            tempCell.isTempCell = true
            tempCells[reuseIdentifier] = tempCell
            return tempCell
        }
    }
    fileprivate func bindingDataAndConstraint(_ tempCell:JDTableCell) {
        tempCell.itemDidLoad(self)
        tempCell.configItemWithElement(self)
        tempCell.itemUpdateConstraints(self)
    }
}
