//
//  BaseMapViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class BaseMapScrollViewController: JDScrollViewController {
    lazy private(set) var mapView = BMKMapView()
    lazy private(set) var positionIndicator:Button = {
        let button = Button(image: R.image.ic_map_positionIndicator())
        return button
    }()
    override func loadView() {
        self.view = self.mapView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.viewWillAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.viewWillDisappear()
    }
}

