//
//  RouterManager+URL.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/10/19.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//
/// ZJaDe: 路线地址
enum RouteUrl {
    case route_活动详情(id:Int)
    case route_活动报名的人
    case route_活动报名页面
    
    case route_吃喝分类_默认(title:String)
    case route_吃喝分类_国内游首页
    case route_吃喝分类_景点首页
    case route_吃喝分类_酒店首页
    case route_吃喝分类_餐饮or特产(title:String)
    case route_吃喝分类_健康or休闲(title:String)

    case route_酒店_详情
    case route_酒店_房间详情(title:String)
    
    case route_我的店铺
    case route_我的店铺_tabbarVC(index:Int)
    case route_我的店铺_店铺活动
    
    case route_优惠券_查看
    case route_优惠券_编辑
    case route_优惠券_详情
    case route_优惠券_添加
}
import UIKit
import JDAnimatedTabBarController

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
            let viewCon = JDDefaultCategoryViewController(title: title)
            return viewCon
        case .route_吃喝分类_国内游首页:
        let viewCon = JDDomesticTravelViewController(title: "国内游")
        return viewCon
        case .route_吃喝分类_景点首页:
            let viewCon = JDTouristViewController(title: "景点")
            return viewCon
        case .route_吃喝分类_酒店首页:
            let viewCon = JDHotelViewController(title: "酒店")
            return viewCon
        case .route_吃喝分类_餐饮or特产(title: let title):
            let viewCon = JDDiningViewController(title: title)
            viewCon.title = title
            return viewCon
        case .route_吃喝分类_健康or休闲(title: let title):
            let viewCon = JDHealthViewController(title: title)
            viewCon.title = title
            return viewCon
            
        case .route_酒店_详情:
            let viewCon = JDHotelDetailViewController()
            return viewCon
        case .route_酒店_房间详情(title: let title):
            let viewCon = JDRoomDetailViewController(title:title)
            return viewCon
            
        case .route_我的店铺:
            let viewCon = JDShopViewController()
            return viewCon
        case .route_我的店铺_tabbarVC(index:let index):
            let viewCon = BaseTabBarController()
            self.configShopTabbarVC(tabbarVC:viewCon)
            viewCon.selectedIndex = index
            return viewCon
        case .route_我的店铺_店铺活动:
            let viewCon = JDShopActivityViewController()
            return viewCon
            
        case .route_优惠券_查看:
            let viewCon = JDShowCouponsViewController()
            return viewCon
        case .route_优惠券_编辑:
            let viewCon = JDEditCouponsViewController()
            return viewCon
        case .route_优惠券_详情:
            let viewCon = JDCouponsDetailViewController()
            return viewCon
        case .route_优惠券_添加:
            let viewCon = JDAddCouponsListViewController()
            return viewCon
        }
    }
}
extension RouterManager {
    static func configShopTabbarVC(tabbarVC:BaseTabBarController) {
        
        tabbarVC.jdTabBar.selectedLayerBackgroundColor = Color.white
        tabbarVC.jdTabBar.jdSeparatorLineColor = Color.white
        tabbarVC.jdTabBar.jdBackgroundColor = Color.viewBackground
        
        func configTabbar(viewCon:BaseViewController,item:JDTabBarItem) {
            viewCon.tabBarItem = item
            item.tabbarColor = (Color.gray,Color.tintColor)
            item.textFont = Font.h5
        }
        let preview:BaseViewController = {
            let viewCon = BaseViewController()
            let item = JDTabBarItem(title: "预览", image: R.image.ic_shop_tabbar_预览(), tag: 1)
            item.animation = JDFlipTopTransitionItemAnimations()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        let QrCode:JDRrCodeViewController = {
            let viewCon = JDRrCodeViewController()
            let item = JDTabBarItem(title: "二维码", image: R.image.ic_shop_tabbar_二维码(), tag: 2)
            item.animation = JDLeftRotationAnimation()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        
        let scan:JDScanViewController = {
            let viewCon = JDScanViewController()
            let item = JDTabBarItem(title: "扫一扫", image: R.image.ic_shop_tabbar_扫一扫(), tag: 3)
            item.animation = JDBounceAnimation()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        
        let share:BaseViewController = {
            let viewCon = BaseViewController()
            let item = JDTabBarItem(title: "分享", image: R.image.ic_shop_tabbar_分享(), tag: 4)
            item.animation = JDFlipLeftTransitionItemAnimations()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        tabbarVC.viewControllers = [preview,QrCode,scan,share]
    }
}
