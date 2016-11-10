
import UIKit

extension NSObject {
    var className:String {
        return type(of: self).className
    }
    static var className:String {
        return jd.namespace + "." + self.classStr
    }
    
    var classStr: String {
        return type(of: self).classStr
    }
    static var classStr: String {
        return String(describing: self)
    }
}
