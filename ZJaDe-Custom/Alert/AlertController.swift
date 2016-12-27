

import UIKit

let alertTitle:String = "温馨提示"
let alertCancelTitle:String = "取消"
let alertConfirmTitle:String = "好的"
let alertIKnowTitle:String = "知道了"


class AlertController: UIAlertController {
    typealias AlertControllerClosureType = (UIAlertAction)->()
    static func alert(title:String? = alertTitle, message:String? = nil) -> AlertController {
        return AlertController(title: title, message: message, preferredStyle: .alert)
    }
    static func actionSheet(title:String? = alertTitle, message:String? = nil) -> AlertController {
        return AlertController(title: title, message: message, preferredStyle: .actionSheet)
    }
    // MARK: -
    func addCancelAction(title:String, _ closure:@escaping AlertControllerClosureType) -> AlertController {
        self.addAction(UIAlertAction(title: title, style: .cancel, handler: { (action) in
            closure(action)
        }))
        return self
    }
    func addDefaultAction(title:String, _ closure:@escaping AlertControllerClosureType) -> AlertController {
        self.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
            closure(action)
        }))
        return self
    }
    func addDestructiveAction(title:String, _ closure:@escaping AlertControllerClosureType) -> AlertController {
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
            _ = self.addCancelAction(title: alertCancelTitle, { (action) in
                
            })
        }
        jd.currentNavC.presentVC(self)
    }
}
extension AlertController {
    static func showPrompt(title:String = alertTitle,_ message:String,_ closure:AlertControllerClosureType? = nil) {
        AlertController.alert(title: title, message: message).addDefaultAction(title: alertIKnowTitle) { (action) in
            closure?(action)
        }.show()
    }
    static func showChoice(title:String, _ message:String, _ closure:AlertControllerClosureType?, _ cancelClosure:AlertControllerClosureType? = nil) {
        AlertController.alert(title: title, message: message).addDefaultAction(title: alertConfirmTitle) { (action) in
            closure?(action)
        }.addCancelAction(title: alertCancelTitle) { (action) in
            cancelClosure?(action)
        }.show()
    }
}
