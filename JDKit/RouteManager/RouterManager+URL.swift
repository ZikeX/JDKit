//
//  RouterManager+URL.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/19.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//
/// ZJaDe: 路线地址
enum RouteUrl {
    case route_活动详情(id:Int)
}
import UIKit

extension RouterManager {
    static func createVC(routeUrl:RouteUrl) -> UIViewController {
        switch routeUrl {
        case .route_活动详情(id:_):
            let activityVC = JDActivityDetailViewController()
            return activityVC
        }
    }
}
