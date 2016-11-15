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
    var viewModel:JDCollectionViewModel! {
        get {
            return self.jdCollectionView.viewModel
        }
        set {
            newValue.listVC = self
            self.jdCollectionView.viewModel = newValue
        }
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
        self.viewModel.configCollectionView(collectionView: self.jdCollectionView)
        self.viewModel.loadLocalSectionModels()
    }
}
