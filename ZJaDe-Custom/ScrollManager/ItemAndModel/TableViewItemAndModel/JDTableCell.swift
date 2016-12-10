//
//  JDTableCell.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDTableCell: UITableViewCell {
    // MARK: - touchCell
    var enabled:Bool = true
    var touchCell:(()->())?
    // MARK: -
    var isTempCell = false
    // MARK: - CellAnimateProtocol
    var appearAnimatedStyle = CellAppearAnimatedStyle.outwardFromCenter
    var highlightAnimatedStyle = CellHighlightAnimatedStyle.touchZoomOut
    var animatedDuration:TimeInterval = 0.25
    // MARK: -
    @IBOutlet var jdContentView:MyContentView!
    var separatorLineView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadContentView()
        configItemInit()
        itemDidInit()
    }
    func loadContentView() {
        self.jdContentView = MyContentView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configItemInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        itemDidInit()
    }
    
    // MARK: - 如果返回大于零，可以不用使用自动计算高度
    func calculateJDContentViewHeight(_ jdContentViewWidth:CGFloat,elementModel:JDTableModel) -> CGFloat {
        return 0
    }
}
extension JDTableCell {//updateCell
    func updateCell(_ model:JDTableModel,_ closure:(()->())?) {
        if let tableView = self.tableView {
            UIView.spring(duration: 0.75, animations: {
                model.invalidateCellHeight()
                model.calculateCellHeight(tableView,wait: true)
                tableView.beginUpdates()
                closure?()
                tableView.endUpdates()
            })
        }else {
            logError("tableView竟然找不到，设计肯定有问题")
        }
    }
    var tableView:JDTableView? {
        var _tableView = self.superview
        while true {
            if _tableView is JDTableView {
                return _tableView as? JDTableView
            }else if _tableView == nil {
                return nil
            }else {
                _tableView = _tableView?.superview
            }
        }
    }
    var indexPath:IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
    
}
extension JDTableCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            touchCell?()
        }
    }
}
// MARK: -
class MyContentView:UIView {
    
}
