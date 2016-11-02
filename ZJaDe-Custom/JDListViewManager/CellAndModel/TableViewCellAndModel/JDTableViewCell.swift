//
//  JDTableViewCell.swift
//  JDTableViewExtensionDemo
//
//  Created by 茶古电子商务 on 16/8/27.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
enum CellAppearAnimatedStyle {
    case zoomIn //从中心往外放大
    case showOut //从内而外显示，同时透明度从0到1
    case custom //自定义
    case none //无动画
}
enum CellHighlightAnimatedStyle {
    case zoomInOut //按下缩小，抬起来还原
    case custom //自定义
    case none //无动画
}
class JDTableViewCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    var isTempCell = false
    
    var appearAnimatedStyle = CellAppearAnimatedStyle.zoomIn
    var highlightAnimatedStyle = CellHighlightAnimatedStyle.zoomInOut
    var selectedAnimated = true
    var animatedDuration:TimeInterval = 0.25
    
    @IBOutlet var jdContentView:MyContentView!
    var separatorLineView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadContentView()
        configCellInit()
        cellDidInit()
    }
    func loadContentView() {
        self.jdContentView = MyContentView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configCellInit()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDidInit()
    }
    // MARK: - cell初始化
    func configCellInit() {
        
    }
    // MARK: - 做一些数据初始化
    func cellDidInit() {
        self.jdContentView.removeFromSuperview()
        self.contentView.addSubview(jdContentView)
        self.contentView.addSubview(separatorLineView)
    }
    // MARK: - cell加载完毕，初始化数据及约束
    func cellDidLoad(_ element: JDTableViewModel) {
        /// ZJaDe:horizontal
        _ = jdContentView.jdLayout.edgesAlign(.horizontal, inset: element.spaceEdges)
        if element.separatorInset.left > 0 {
            _ = separatorLineView.jdLayout.leftAlign(offset: element.separatorInset.left)
        }else {
            _ = separatorLineView.jdLayout.leftAlign(self,offset: -element.separatorInset.left)
        }
        if element.separatorInset.right > 0 {
            _ = separatorLineView.jdLayout.rightAlign(offset: -element.separatorInset.right)
        }else {
            _ = separatorLineView.jdLayout.rightAlign(self,offset: element.separatorInset.right)
        }
        /// ZJaDe:vertical
        jdContentView.jdLayout.topAlign(offset: element.spaceEdges.top).activate()
        
        separatorLineView.jdLayout
        .bottomAlign(offset: -element.separatorInset.bottom)
        .topSpace(jdContentView, space: element.spaceEdges.bottom + element.separatorInset.top)
        .heightValue(height: element.lineHeight)
        .activate()
    }
    // MARK: - cell将要显示，做动画，element绑定cell
    final func cellWillAppear(_ element: JDTableViewModel) {
        switch appearAnimatedStyle {
        case .zoomIn:
            self.zoomIn(self.animatedDuration)
        case .showOut:
            self.showOut(self.animatedDuration)
        case .custom:
            self.customAnimate(self.animatedDuration)
            break
        case .none:
            break
        }
        self.configCellWithElement(element)
        self.cellUpdateConstraints(element)
    }
    // MARK: 自定义动画
    func customAnimate(_ animatedDuration:TimeInterval) {
        
    }
    // MARK: cell根据element绑定数据
    func configCellWithElement(_ element: JDTableViewModel) {
        self.selectedBackgroundView = element.cellSelectedBackgroundView
        if let color = element.cellSelectedBackgroundColor {
            self.selectedBackgroundView?.backgroundColor = color
        }
        if let color = element.cellBackgroundColor {
            self.backgroundColor = color
        }
        separatorLineView.backgroundColor = element.lineColor
    }
    // MARK: cell设置数据后,如果需要在这里更新约束
    func cellUpdateConstraints(_ element: JDTableViewModel) {
        self.setNeedsUpdateConstraints()
    }
    // MARK: - cell已经消失,element解绑cell
    func cellDidDisappear(_ element: JDTableViewModel) {
        disposeBag = DisposeBag()
    }
    // MARK: - 如果返回大于零，可以不用使用自动计算高度
    func calculateJDContentViewHeight(_ jdContentViewWidth:CGFloat,elementModel:JDTableViewModel) -> CGFloat {
        return 0
    }
}
extension JDTableViewCell {//cell高亮或者点击

    override func setSelected(_ selected: Bool, animated: Bool) {
        if self.selectedAnimated {
            super.setSelected(selected, animated: animated)            
        }
    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        switch highlightAnimatedStyle {
        case .zoomInOut:
            self.zoomInOut(self.animatedDuration, ZoomIn: highlighted)
        case .custom:
            super.setHighlighted(highlighted, animated: animated)
        case .none:
            break
        }
    }
}
extension JDTableViewCell {//cellReload
    func cellReload(model:JDTableViewModel) {
        model.invalidateCellHeight()
        if let indexPath = self.indexPath,let tableView = self.tableView {
            tableView.reloadItemsAtIndexPaths([indexPath], animationStyle: tableView.reloadDataSource.rowAnimation)
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
// MARK: -
class MyContentView:UIView {
    
}
