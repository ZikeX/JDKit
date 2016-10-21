
import UIKit

#if os(iOS)

extension UISwitch {
	func toggle() {
		self.setOn(!self.isOn, animated: true)
	}
}

#endif
