//
//  BaseCollectionViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class BaseCollectionViewModel: JDCollectionViewModel {
    
    func createBaseCollectionView() -> BaseCollectionView {
        let collectionView = BaseCollectionView()
        collectionView.viewModel = self
        self.configCollectionView(collectionView: collectionView)
        self.loadLocalSectionModels()
        return collectionView
    }
}
