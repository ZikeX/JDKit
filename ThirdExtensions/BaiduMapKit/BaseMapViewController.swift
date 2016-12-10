//
//  BaseMapViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class BaseMapViewController: BaseViewController {
    var mapVC:BaseMapScrollViewController {
        return self.firstChildVC!
    }
    var mapView:BMKMapView {
        return self.mapVC.mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildScrollVC(edgesToFill: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.delegate = nil
    }
}

extension BaseMapViewController:AddChildScrollProtocol {
    func createScrollVC(index: Int) -> BaseMapScrollViewController {
        return BaseMapScrollViewController()
    }
}
extension BaseMapViewController:BMKMapViewDelegate {
    
}
