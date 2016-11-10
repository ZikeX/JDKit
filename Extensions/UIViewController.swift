
import UIKit
extension UIViewController {
    func configNavBarItem(closure:((UINavigationItem) -> ())?) {
        func clearNavigationItem() {
            self.navigationItem.titleView?.removeFromSuperview()
            self.navigationItem.titleView = nil
            self.navigationItem.title = nil
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem]()
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem]()
        }
        clearNavigationItem()
        closure?(self.navigationItem)
    }
}
extension UIViewController {
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
extension UIViewController {
    // MARK: - VC Flow
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    func popVC(animated:Bool = true) {
        _ = navigationController?.popViewController(animated: animated)
    }
    func presentVC(_ vc: UIViewController,animated:Bool = true) {
        present(vc, animated: animated, completion: nil)
    }
    func dismissVC(animated:Bool = true,completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        toView.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }
}
extension UIViewController {
    /// ZJaDe: Adds image named: as a ImageView in the Background
    func setBackgroundImage(_ named: String) {
        let image = UIImage(named: named)
        setBackgroundImage(image)
    }

    /// ZJaDe: Adds UIImage as a ImageView in the Background
    @nonobjc func setBackgroundImage(_ image: UIImage?) {
        let imageView = ImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
}
extension UIViewController {
    #if os(iOS)
    
    func addKeyboardWillShowNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardWillShow.rawValue, selector: #selector(UIViewController.keyboardWillShowNotification(_:)))
    }
    
    func addKeyboardDidShowNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidShow.rawValue, selector: #selector(UIViewController.keyboardDidShowNotification(_:)))
    }
    
    func addKeyboardWillHideNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardWillHide.rawValue, selector: #selector(UIViewController.keyboardWillHideNotification(_:)))
    }
    
    func addKeyboardDidHideNotification() {
        self.addNotificationObserver(NSNotification.Name.UIKeyboardDidHide.rawValue, selector: #selector(UIViewController.keyboardDidHideNotification(_:)))
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
    
    #endif
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension UIViewController {
    // MARK: - VC Container
    var top: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.top
            }
            if let nav = self.navigationController {
                if nav.isNavigationBarHidden {
                    return view.top
                } else {
                    return nav.navigationBar.bottom
                }
            } else {
                return view.top
            }
        }
    }
    var bottom: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.bottom
            }
            if let tab = tabBarController {
                if tab.tabBar.isHidden {
                    return view.bottom
                } else {
                    return tab.tabBar.top
                }
            } else {
                return view.bottom
            }
        }
    }
    var tabBarHeight: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.tabBarHeight
            }
            if let tab = self.tabBarController {
                return tab.tabBar.frame.size.height
            }
            return 0
        }
    }
    var navigationBarHeight: CGFloat {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarHeight
            }
            if let nav = self.navigationController {
                return nav.navigationBar.height
            }
            return 0
        }
    }
    var navigationBarColor: UIColor? {
        get {
            if let me = self as? UINavigationController, let visibleViewController = me.visibleViewController {
                return visibleViewController.navigationBarColor
            }
            return navigationController?.navigationBar.tintColor
        } set(value) {
            navigationController?.navigationBar.barTintColor = value
        }
    }
    var navBar: UINavigationBar? {
        get {
            return navigationController?.navigationBar
        }
    }
    var applicationFrame: CGRect {
        get {
            return CGRect(x: view.x, y: top, width: view.width, height: bottom - top)
        }
    }
}
