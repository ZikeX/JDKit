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
    
    var sectionModels = Variable([AnimatableSectionModel<JDCollectionViewSection,JDCollectionViewModel>]())
    let rxDataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatableSectionModel<JDCollectionViewSection,JDCollectionViewModel>>()
    var dataArray = [(JDCollectionViewSection,[JDCollectionViewModel])]()
    
    // MARK: - init
    convenience init() {
        self.init(collectionViewLayout: UICollectionViewFlowLayout())
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
    func getLocalSectionModels() -> [(JDCollectionViewSection, [JDCollectionViewModel])]? {
        return nil
    }
}
extension JDCollectionView:UICollectionViewDelegate {
    func configDelegate() {
//        self.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
    // MARK: - display
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionViewCell {
            let model = rxDataSource[indexPath]
            cell.cellDidLoad(model)
            cell.cellWillAppear(model)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? JDCollectionViewCell {
            let model = rxDataSource[indexPath]
            cell.cellDidDisappear(model)
        }
    }
}
