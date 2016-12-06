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
    lazy private(set) var zoomView:MapZoom = MapZoom()
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
class MapZoom: CustomIBView {
    /// ZJaDe: 放大
    let zoomIn:Button = {
        let button = Button(image: R.image.ic_加号(), isTemplate: true)
        button.tintColor = Color.gray
        button.addBorderBottom(padding:5)
        return button
    }()
    /// ZJaDe: 缩小
    let zoomOn:Button = {
        let button = Button(image: R.image.ic_减号(), isTemplate: true)
        button.tintColor = Color.gray
        return button
    }()
    override func configInit() {
        super.configInit()
        self.backgroundColor = Color.white.withAlphaComponent(0.8)
        self.cornerRadius = 5
        self.addShadow()
        self.addSubview(self.zoomIn)
        self.addSubview(self.zoomOn)
        self.zoomIn.snp.makeConstraints { (maker) in
            maker.left.centerX.top.equalToSuperview()
        }
        self.zoomOn.snp.makeConstraints { (maker) in
            maker.left.centerX.bottom.equalToSuperview()
            maker.topSpace(self.zoomIn)
            maker.height.equalTo(self.zoomIn)
        }
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 37.5, height: 88)
    }
}
