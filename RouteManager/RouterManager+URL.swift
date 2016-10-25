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
    case route_活动报名的人
    case route_活动报名页面
    case route_酒店首页
    case route_酒店详情
    case route_餐饮
}
import UIKit

extension RouterManager {
    static func createVC(routeUrl:RouteUrl) -> UIViewController {
        switch routeUrl {
        case .route_活动详情(id:_):
            let activityVC = JDActivityDetailViewController()
            return activityVC
        case .route_活动报名的人:
            let viewCon = JDActivityEnrolNumViewController()
            return viewCon
        case .route_活动报名页面:
            let viewCon = JDActivityEnrollViewController()
            return viewCon
        case .route_酒店首页:
            let viewCon = JDHotelViewController()
            return viewCon
        case .route_酒店详情:
            let viewCon = JDHotelDetailViewController()
            return viewCon
        case .route_餐饮:
            let viewCon = JDDiningViewController()
            return viewCon
        }
    }
}
