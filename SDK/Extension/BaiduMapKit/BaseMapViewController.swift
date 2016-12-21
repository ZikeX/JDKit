//
//  BaseMapViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

class BaseMapViewController: BaseViewController {
    var headerShadowView:UIView = {
        let view = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: -106, width: jd.screenWidth, height: 212)
        gradientLayer.colors = [Color.darkBlack,Color.clear]
        gradientLayer.locations = [0,1]
        view.layer.addSublayer(gradientLayer)
        view.frame = CGRect(x: 0, y: 0, width: jd.screenWidth, height: 106)
        return view
    }()
    lazy var mapVC:BaseMapScrollViewController = BaseMapScrollViewController()
    
    var mapView:BMKMapView {
        return self.mapVC.mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildScrollVC(edgesToFill: true)
        self.view.addSubview(self.headerShadowView)
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
        return self.mapVC
    }
}
extension BaseMapViewController:BMKMapViewDelegate {
    
}
