
import UIKit
protocol ClassNameProtocol {
    var className:String {get}
    static var className:String {get}
    
    var classStr: String {get}
    static var classStr: String {get}
}
extension ClassNameProtocol {
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
extension NSObject:ClassNameProtocol {
    
}
