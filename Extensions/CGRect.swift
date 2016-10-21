

import UIKit

extension CGRect {
    var x: CGFloat {
        get {
            return self.origin.x
        } set(value) {
            self.origin.x = value
        }
    }
    var y: CGFloat {
        get {
            return self.origin.y
        } set(value) {
            self.origin.y = value
        }
    }
    var width: CGFloat {
        get {
            return self.size.width
        } set(value) {
            self.size.width = value
        }
    }
    var height: CGFloat {
        get {
            return self.size.height
        } set(value) {
            self.size.height = value
        }
    }

}
