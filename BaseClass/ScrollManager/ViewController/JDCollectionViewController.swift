//
//  JDCollectionViewController.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/11/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class JDCollectionViewController: JDListViewController {
    lazy private(set) var collectionView:JDCollectionView = JDCollectionView(viewModel:self.viewModel)
    
    var viewModel:JDCollectionViewModel {
        didSet {
            viewModel.listVC = self
            self.collectionView.viewModel = viewModel
            self.viewModel.resetInit()
        }
    }
    init(viewModel:JDCollectionViewModel) {
        self.viewModel = viewModel
        super.init()
        viewModel.listVC = self
        configInit()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("暂不支持xib")
    }
    
    override func loadView() {
        self.view = self.collectionView
    }

    // MARK: - 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.resetInit()
    }
}
