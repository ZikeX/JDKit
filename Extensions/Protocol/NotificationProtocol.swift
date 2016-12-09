//
//  NotificationCenterProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit
protocol NotificationCenterProtocol:class {
    func addNotificationObserver(_ name: String, selector: Selector)
    func removeNotificationObserver(_ name: String)
    func removeNotificationObserver()
}
extension NotificationCenterProtocol where Self:NSObject {
    // MARK: - Notifications
    func addNotificationObserver(_ name: String, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name), object: nil)
    }
    
    func removeNotificationObserver(_ name: String) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name), object: nil)
    }
    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
extension UIViewController:NotificationCenterProtocol {
}
