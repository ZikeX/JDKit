//
//  JDCollectionViewController.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDCollectionViewController: UICollectionViewController {
    
    var jdCollectionView:JDCollectionView {
        return self.collectionView as! JDCollectionView
    }
    
    let viewModel:JDCollectionViewModel
    init(viewModel:JDCollectionViewModel) {
        self.viewModel = viewModel
        super.init(collectionViewLayout: self.viewModel.layout)
        viewModel.listVC = self
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("暂不支持xib")
    }
    
    override func loadView() {
        self.collectionView = JDCollectionView(viewModel:self.viewModel)
    }
    func configInit() {
        
    }
    // MARK: - 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.resetInit()
    }
}
