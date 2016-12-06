//
//  AppConfig.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/6.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
import JDAnimatedTabBarController

class AppConfig {
    static func appearance() {
        let navigationBar = UINavigationBar.appearance()
        navigationBar.backIndicatorImage = R.image.ic_back()
        navigationBar.backIndicatorTransitionMaskImage = R.image.ic_back()
    }
    static func rootVC(_ delegate:AppDelegate) {
        let window = UIWindow()
        window.backgroundColor = Color.white
        delegate.window = window
        window.tintColor = Color.tintColor
        
        let tabbarVC = BaseTabBarController()
        tabbarVC.jdTabBar.selectedLayerBackgroundColor = Color.white
        tabbarVC.jdTabBar.jdSeparatorLineColor = Color.white
        tabbarVC.jdTabBar.jdBackgroundColor = Color.viewBackground
        
        func configTabbar(viewCon:BaseViewController,item:JDTabBarItem) {
            viewCon.tabBarItem = item
            item.tabbarColor = (Color.gray,Color.tintColor)
            item.textFont = Font.h5
        }
        let home:JDHomeViewController = {
            let viewCon = JDHomeViewController()
            let item = JDTabBarItem(title: "首页", image: R.image.ic_tabbar_home(), tag: 1)
            item.animation = JDBounceAnimation()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        let nearby:JDNearbyViewController = {
            let viewCon = JDNearbyViewController()
            let item = JDTabBarItem(title: "周边", image: R.image.ic_tabbar_nearby(), tag: 2)
            item.animation = JDBounceAnimation()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        
        let play:JDPlayViewController = {
            let viewCon = JDPlayViewController()
            let item = JDTabBarItem(title: "吃喝", image: R.image.ic_tabbar_play(), tag: 3)
            item.animation = JDFlipTopTransitionItemAnimations()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        
        let travel:JDTravelViewController = {
            let viewCon = JDTravelViewController()
            let item = JDTabBarItem(title: "游记", image: R.image.ic_tabbar_travel(), tag: 4)
            item.animation = JDFlipLeftTransitionItemAnimations()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        
        let mine:JDMineViewController = {
            let viewCon = JDMineViewController()
            let item = JDTabBarItem(title: "我的", image: R.image.ic_tabbar_mine(), tag: 5)
            item.animation = JDFumeAnimation()
            configTabbar(viewCon:viewCon,item: item)
            return viewCon
        }()
        tabbarVC.viewControllers = [home,nearby,play,travel,mine]
        
        let navC = BaseNavigationController(rootViewController: tabbarVC)
        //        navC.viewControllers = [tabbarVC,play,travel,mine]
        window.rootViewController = navC
        window.makeKeyAndVisible()
        CoreLaunch.animate(window: window)
    }
}
