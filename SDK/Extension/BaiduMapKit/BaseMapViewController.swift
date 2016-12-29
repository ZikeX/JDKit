//
//  BaseMapViewController.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
import RxSwift

class BaseMapViewController: BaseViewController {
    lazy var searchView:UIView = UIView()
    lazy var searchTextField:SearchTextField = SearchTextField(textFieldType: .lightWhiteSearchBarWithCity)
    /// ZJaDe: 
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
    var currentLocation:BMKUserLocation?
    private var needShowMyLocation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildScrollVC(edgesToFill: true)
        self.view.addSubview(self.headerShadowView)
        
        self.navBarAlpha = 0.9
        self.navTintColor = Color.black
        self.backButton.addShadowInWhiteView()
        self.configNavBarItem { (navItem) in
            navItem.leftBarButtonItem = self.backButton.barButtonItem()
            navItem.titleView = self.searchView
        }
        configSearchView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedToRequest()
        mapView.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView.delegate = nil
    }
    override func request() {
        BMKLocationManager().location().subscribe(onNext:{[unowned self] (userLocation) in
            self.currentLocation = userLocation
            self.updateData()
            if self.needShowMyLocation {
                self.needShowMyLocation = false
                self.mapVC.showMyLocation()
            }
            self.didUpdateLocation.onNext(userLocation)
        }).addDisposableTo(disposeBag)
    }
    override func updateData() {
        self.mapView.updateLocationData(self.currentLocation)
    }
    // MARK: - BMKMapViewDelegate
    var regionDidChange = PublishSubject<Void>()
    var didUpdateLocation = PublishSubject<BMKUserLocation>()
}
extension BaseMapViewController {
    // MARK: searchView
    func configSearchView() {
        searchTextField.text = "   目的地、景点、酒店、"
        searchView.addSubview(searchTextField)
        searchView.size = searchTextField.intrinsicContentSize
        searchTextField.edgesToView()
        _ = searchView.rx.whenTouch({ (view) in
            // TODO: 点击搜索框时
        })
        searchTextField.backgroundColor = Color.clear
    }
}
extension BaseMapViewController:AddChildScrollProtocol {
    func createScrollVC(index: Int) -> BaseMapScrollViewController {
        return self.mapVC
    }
}
extension BaseMapViewController:BMKMapViewDelegate {
    func mapViewDidFinishLoading(_ mapView: BMKMapView!) {
        
    }
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        self.regionDidChange.onNext()
    }
}
