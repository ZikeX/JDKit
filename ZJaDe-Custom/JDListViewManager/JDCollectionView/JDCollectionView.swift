//
//  JDCollectionView.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/21.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift
class JDCollectionView: UICollectionView {
    let disposeBag = DisposeBag()
    
    let reloadDataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<JDCollectionViewSection,JDCollectionViewModel>>()
    var dataArray = Variable([SectionModel<JDCollectionViewSection,JDCollectionViewModel>]())
    
    // MARK: - init
    convenience init() {
        let flowLayout = UICollectionViewFlowLayout()
        self.init(collectionViewLayout:flowLayout);
    }
    override init(frame: CGRect = CGRect(), collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    func configInit() {
        self.backgroundColor = Color.white
        configDataSource()
        configDelegate()
    }
}
extension JDCollectionView {
    func configDataSource() {
        reloadDataSource.configureCell = {(dataSource,colectionView,indexPath,model) in
            let cell = colectionView.dequeueReusableCell(withReuseIdentifier: model.reuseIdentifier, for: indexPath) as! JDCollectionViewCell
            cell.cellDidLoad(model)
            return cell
        }
        self.dataArray.asObservable().bindTo(self.rx.items(dataSource: reloadDataSource)).addDisposableTo(disposeBag)
    }
}
extension JDCollectionView:UICollectionViewDelegate {
    func configDelegate() {
        self.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    // MARK: - display
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionViewCell {
            let model = reloadDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionViewCell {
            let model = reloadDataSource[indexPath]
            cell.cellDidDisappear(model)
        }
    }
}
