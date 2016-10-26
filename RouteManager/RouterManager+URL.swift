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
    
    case route_吃喝分类_默认(title:String)
    case route_吃喝分类_景点首页
    case route_吃喝分类_酒店首页
    case route_吃喝分类_酒店_详情
    case route_吃喝分类_餐饮or特产(title:String)
    case route_吃喝分类_健康or休闲(title:String)
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
        
        case .route_吃喝分类_默认(title: let title):
            let viewCon = JDDefaultCategoryViewController()
            viewCon.title = title
            return viewCon
        case .route_吃喝分类_景点首页:
            let viewCon = JDTouristViewController()
            viewCon.title = "景点"
            return viewCon
        case .route_吃喝分类_酒店首页:
            let viewCon = JDHotelViewController()
            viewCon.title = "酒店"
            return viewCon
        case .route_吃喝分类_酒店_详情:
            let viewCon = JDHotelDetailViewController()
            return viewCon
        case .route_吃喝分类_餐饮or特产(title: let title):
            let viewCon = JDDiningViewController()
            viewCon.title = title
            return viewCon
        case .route_吃喝分类_健康or休闲(title: let title):
            let viewCon = JDHealthViewController()
            viewCon.title = title
            return viewCon
            
        }
    }
}
