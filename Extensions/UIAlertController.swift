

import UIKit

extension UIAlertController {
    static func alert(title:String? = "您好", message:String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    static func actionSheet(title:String? = "您好", message:String? = nil) -> UIAlertController {
        return UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    // MARK: -
    func addCancelAction(title:String, _ closure:@escaping (UIAlertAction)->()) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .cancel, handler: { (action) in
            closure(action)
        }))
        return self
    }
    func addDefaultAction(title:String, _ closure:@escaping (UIAlertAction)->()) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            closure(action)
        }))
        return self
    }
    func addDestructiveAction(title:String, _ closure:@escaping (UIAlertAction)->()) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .destructive, handler: { (action) in
            closure(action)
        }))
        return self
    }
    // MARK: - 
    func show() {
        var hasCancelAction = false
        for action in self.actions {
            if action.style == .cancel {
                hasCancelAction = true
                break
            }
        }
        if hasCancelAction == false {
            _ = self.addCancelAction(title: "取消", { (action) in
                
            })
        }
        jd.currentNavC.presentVC(self)
    }
}
