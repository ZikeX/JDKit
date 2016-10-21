
import UIKit

extension NSObject {
    var className:String {
        return type(of: self).className
    }
    static var className:String {
        return jd.namespace + "." + self.name
    }
    
    var name: String {
        return type(of: self).name
    }
    static var name: String {
        return String(describing: self)
    }
}
