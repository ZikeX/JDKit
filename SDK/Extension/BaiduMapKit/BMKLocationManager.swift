//
//  BMKLocationManager.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/28.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import PermissionScope
import RxSwift

class BMKLocationManager:NSObject {
    // MARK: 反编码 坐标转地址
    lazy var geoCodeSearch = BMKGeoCodeSearch()
    fileprivate lazy var reverseGeoCodeSubject = ReplaySubject<AddressComponentModel>.create(bufferSize: 1)
    // MARK: 定位
    lazy var locationService = BMKLocationService()
    fileprivate lazy var locationSubject = ReplaySubject<BMKUserLocation>.create(bufferSize: 1)
    
}
// MARK: - 反编码 坐标转地址
extension BMKLocationManager {
    func locationAndReverseGeoCode() -> Observable<AddressComponentModel> {
        return self.getLocation().flatMap {[unowned self] (location) -> Observable<AddressComponentModel> in
            return self.reverseGeoCode(location.location.coordinate)
        }
    }
    func reverseGeoCode(_ coordinate:CLLocationCoordinate2D) -> Observable<AddressComponentModel> {
        self.beginSearch(coordinate)
        return self.reverseGeoCodeSubject.retry(3).take(1).do( onDispose: {
            self.endSearch()
        })
    }
    fileprivate func beginSearch(_ coordinate:CLLocationCoordinate2D) {
        self.geoCodeSearch.delegate = self
        let result = BMKReverseGeoCodeOption()
        result.reverseGeoPoint = coordinate
        if self.geoCodeSearch.reverseGeoCode(result) == false {
            self.reverseGeoCodeSubject.onError(NSError(domain: "反geo检索失败", code: -1, userInfo: nil))
            logDebug("反geo检索发送失败")
        }
    }
    func endSearch() {
        geoCodeSearch.delegate = nil
    }
}
// MARK: - 反编码 坐标转地址 BMKGeoCodeSearchDelegate
extension BMKLocationManager:BMKGeoCodeSearchDelegate {
    /// ZJaDe: 地址信息搜索结果
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
    }
    /// ZJaDe: 返回反地理编码搜索结果
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if result.address != nil, result.address.length > 0 {
            let addressModel = AddressComponentModel()
            addressModel.province = result.addressDetail.province
            addressModel.city = result.addressDetail.city
            addressModel.area = result.addressDetail.district
            addressModel.streetName = result.addressDetail.streetName
            addressModel.streetNumber = result.addressDetail.streetNumber
            addressModel.coordinate = result.location
            
            self.reverseGeoCodeSubject.onNext(addressModel)
        }else if (error != BMK_SEARCH_NO_ERROR) {
            HUD.showError("反编码错误->\(error)")
        }
    }
}
// MARK: - 定位
extension BMKLocationManager {
    func getLocation() -> Observable<BMKUserLocation> {
        return self.location().take(1)
    }
    // MARK: 开启定位同时验证
    func location() -> Observable<BMKUserLocation> {
        self.checkCanLocation {
            self.startUserLocationService()
        }
        return self.locationSubject.retry(3).do(onDispose: {
            self.endLocation()
        })
    }
    // MARK: 只请求定位，不提示错误
    func onlyLocation() -> Observable<BMKUserLocation> {
        self.startUserLocationService()
        return self.locationSubject.retry(3).do(onDispose: {
            self.endLocation()
        })
    }
    // MARK: 停止定位
    func endLocation() {
        self.stopUserLocationService()
    }
    // MARK: - 
    fileprivate func startUserLocationService() {
        if self.locationService.delegate == nil {
            self.locationService.delegate = self
            self.locationService.startUserLocationService()
        }
    }
    fileprivate func stopUserLocationService() {
        self.locationService.stopUserLocationService()
        self.locationService.delegate = nil
        
    }
    fileprivate func checkCanLocation(_ closure:@escaping ()->()) {
        let pscope = PermissionScope()
        pscope.addPermission(LocationWhileInUsePermission(), message: "如果拒绝将无法使用定位功能")
        pscope.bodyLabel.text = "在您定位之前，app需要获取\r\niPhone的定位权限"
        pscope.show({ (finished, results) in
            closure()
        }, cancelled: {(results) in
        })
    }
    // MARK: 更新定位
    fileprivate func updateLocation(_ userLocation:BMKUserLocation) {
        if let coordinate = userLocation.location?.coordinate {
            UserInfo.shared.personModel.coordinate = coordinate
            self.locationSubject.onNext(userLocation)
        }
    }
}
// MARK: - 定位 BMKLocationServiceDelegate
extension BMKLocationManager:BMKLocationServiceDelegate {
    func willStartLocatingUser() {
        logInfo("开始定位")
    }
    func didStopLocatingUser() {
        logInfo("停止定位")
    }
    
    func didUpdate(_ userLocation: BMKUserLocation!) {
        updateLocation(userLocation)
    }
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {
        updateLocation(userLocation)
    }
    func didFailToLocateUserWithError(_ error: Error!) {
        HUD.showError("定位出现位置错误")
        self.locationSubject.onError(error)
    }
}
