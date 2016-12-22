//
//  RouterManager.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/10/19.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

/// ZJaDe: 路线类型
enum RouteType {
    case push
    case present
    case popAndPush(popCount:Int)
}
protocol RouteUrlType {
    func createViewCon(_ manager:RouterManager) -> UIViewController?
}
import UIKit
/// ZJaDe: 路由器管理
class RouterManager {
    let routeType:RouteType
    init(_ routeType:RouteType) {
        self.routeType = routeType
    }
    static func popAndPush(_ routeUrl:RouteUrlType, popCount:Int = 1) {
        let routerManager = RouterManager(.popAndPush(popCount: popCount))
        routerManager.show(routeUrl)
    }
    static func push(_ routeUrl:RouteUrlType) {
        let routerManager = RouterManager(.push)
        routerManager.show(routeUrl)
    }
    static func present(_ routeUrl:RouteUrlType, completion:((Any?)->Void)? = nil) {
        let routerManager = RouterManager(.present)
        routerManager.show(routeUrl, completion)
    }
    // MARK: -
    /// ZJaDe: completion只有在present时有用
    private func show(_ routeUrl:RouteUrlType, _ completion:(()->Void)? = nil) {
        let currentNavc = jd.currentNavC
        
//        guard checkCanJump(currentNavc) else {
//            return
//        }
        jd.endEditing()
        guard let viewController = routeUrl.createViewCon(self) else {
            logDebug("跳转失败")
            return
        }
        switch self.routeType {
        case .popAndPush(let count):
            currentNavc.popAndPush(count: count, pushVC: viewController, animated: true)
        case .push:
            currentNavc.pushViewController(viewController, animated: true)
        case .present:
            let viewCon:UINavigationController
            if viewController is UINavigationController {
                viewCon = viewController as! UINavigationController
            }else {
                viewCon = BaseNavigationController(rootViewController: viewController)
            }
            currentNavc.present(viewCon, animated: true, completion: completion)
        }
    }
    /// ZJaDe: BasePreviewViewController
    static func checkCanJump(_ navC:UINavigationController) -> Bool {
        let currentVC:UIViewController?
        let topVC = navC.topViewController
        if let topVC = topVC as? UITabBarController {
            currentVC = topVC.selectedViewController
        }else {
            currentVC = topVC
        }
        if currentVC is BasePreviewViewController {
            return false
        }
        return true
    }
}
