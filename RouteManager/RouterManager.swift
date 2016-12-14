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

import UIKit
/// ZJaDe: 路由器管理
class RouterManager {
    let routeType:RouteType
    init(_ routeType:RouteType) {
        self.routeType = routeType
    }
    static func popAndPush(_ routeUrl:RouteUrl, popCount:Int = 1, completion:(()->Void)? = nil) {
        let routerManager = RouterManager(.popAndPush(popCount: popCount))
        routerManager.show(routeUrl, completion)
    }
    static func push(_ routeUrl:RouteUrl, completion:((Any?)->Void)? = nil) {
        let routerManager = RouterManager(.push)
        routerManager.show(routeUrl, completion)
    }
    static func present(_ routeUrl:RouteUrl, completion:((Any?)->Void)? = nil) {
        let routerManager = RouterManager(.present)
        routerManager.show(routeUrl, completion)
    }
    // MARK: -
    /// ZJaDe: completion只有在present时有用
    private func show(_ routeUrl:RouteUrl, _ completion:(()->Void)?) {
        let currentNavc = jd.currentNavC
        
//        guard checkCanJump(currentNavc) else {
//            return
//        }
        jd.endEditing()
        let viewController = createVC(routeUrl: routeUrl)
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
