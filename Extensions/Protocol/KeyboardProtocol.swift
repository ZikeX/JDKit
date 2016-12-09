//
//  KeyboardProtocol.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/12/9.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

protocol KeyboardProtocol:NotificationCenterProtocol {
    #if os(iOS)
    func addKeyboardWillShowNotification()
    func addKeyboardDidShowNotification()
    func addKeyboardWillHideNotification()
    func addKeyboardDidHideNotification()
    
    func removeKeyboardWillShowNotification()
    func removeKeyboardDidShowNotification()
    func removeKeyboardWillHideNotification()
    func removeKeyboardDidHideNotification()
    
    func keyboardWillShowWithFrame(_ frame: CGRect)
    func keyboardDidShowWithFrame(_ frame: CGRect)
    func keyboardWillHideWithFrame(_ frame: CGRect)
    func keyboardDidHideWithFrame(_ frame: CGRect)
    #endif
}
extension UIViewController:KeyboardProtocol {
    #if os(iOS)
    
    func addKeyboardWillShowNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardWillShow.rawValue, selector: #selector(keyboardWillShowNotification(_:)))
    }
    
    func addKeyboardDidShowNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidShow.rawValue, selector: #selector(keyboardDidShowNotification(_:)))
    }
    
    func addKeyboardWillHideNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardWillHide.rawValue, selector: #selector(keyboardWillHideNotification(_:)))
    }
    
    func addKeyboardDidHideNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidHide.rawValue, selector: #selector(keyboardDidHideNotification(_:)))
    }
    
    func removeKeyboardWillShowNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardWillShow.rawValue)
    }
    
    func removeKeyboardDidShowNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardDidShow.rawValue)
    }
    
    func removeKeyboardWillHideNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardWillHide.rawValue)
    }
    
    func removeKeyboardDidHideNotification() {
        self.removeNotificationObserver(NSNotification.Name.UIKeyboardDidHide.rawValue)
    }
    func keyboardDidShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidShowWithFrame(frame)
        }
    }
    
    func keyboardWillShowNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillShowWithFrame(frame)
        }
    }
    
    func keyboardWillHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardWillHideWithFrame(frame)
        }
    }
    
    func keyboardDidHideNotification(_ notification: Notification) {
        if let nInfo = (notification as NSNotification).userInfo, let value = nInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let frame = value.cgRectValue
            keyboardDidHideWithFrame(frame)
        }
    }
    #endif
}
extension UIViewController {
    
    
    func keyboardWillShowWithFrame(_ frame: CGRect) {
    
    }
    
    func keyboardDidShowWithFrame(_ frame: CGRect) {
    
    }
    
    func keyboardWillHideWithFrame(_ frame: CGRect) {
    
    }
    
    func keyboardDidHideWithFrame(_ frame: CGRect) {
    
    }
    
    /// ZJaDe: Makes the UIViewController register tap events and hides keyboard when clicked somewhere in the ViewController.
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
