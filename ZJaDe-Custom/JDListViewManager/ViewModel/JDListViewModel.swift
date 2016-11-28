//
//  JDListViewModel.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/15.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
import RxSwift

class JDListViewModel: NSObject {
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        self.configInit()
    }
    func configInit() {
        
    }
}

extension JDListViewModel {/// ZJaDe: EmptyDataSet
    // MARK: - 设置EmptyDataSet内容
    func configEmptyDataSetNoData(_ contentView:UIStackView) {
        let label = UILabel(text: "无数据", color: Color.gray, font: Font.h1)
        contentView.addArrangedSubview(label)
    }
    func configEmptyDataSetLoadFailed(_ contentView:UIStackView) {
        
    }
    func configEmptyDataSetLoading(_ contentView:UIStackView) {
        
    }
}
