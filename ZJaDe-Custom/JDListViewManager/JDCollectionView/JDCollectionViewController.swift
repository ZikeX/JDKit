//
//  JDCollectionViewController.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDCollectionViewController: UICollectionViewController {
    let disposeBag = DisposeBag()
    
    var jdCollectionView:JDCollectionView {
        return self.collectionView as! JDCollectionView
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        super.init(collectionViewLayout: layout)
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configInit()
    }
    
    override func loadView() {
        self.collectionView = JDCollectionView(collectionViewLayout: self.collectionViewLayout)
    }
    func configInit() {
        
    }
    // MARK: - 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLocalSectionModels()
    }
    func getLocalSectionModels() -> [(JDCollectionViewSection, [JDCollectionViewModel])]? {
        return nil
    }
}
