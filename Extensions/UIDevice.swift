

import UIKit

private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPod 6 */          "iPod7,1": "iPod Touch 6",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* iPhone 6S */       "iPhone8,1": "iPhone 6S",
    /* iPhone 6S Plus */  "iPhone8,2": "iPhone 6S Plus",

    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
    /* iPad Air 2 */      "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */     "iPad4,4": "iPad Mini 2", "iPad4,5": "iPad Mini 2", "iPad4,6": "iPad Mini 2",
    /* iPad Mini 3 */     "iPad4,7": "iPad Mini 3", "iPad4,8": "iPad Mini 3", "iPad4,9": "iPad Mini 3",
    /* iPad Mini 4 */     "iPad5,1": "iPad Mini 4", "iPad5,2": "iPad Mini 4",
    /* iPad Pro */        "iPad6,7": "iPad Pro", "iPad6,8": "iPad Pro",
    /* AppleTV */         "AppleTV5,3": "AppleTV",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

extension UIDevice {
    /// ZJaDe: idForVendor
    class func idForVendor() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }

    /// ZJaDe: systemName
    class func systemName() -> String {
        return UIDevice.current.systemName
    }

    /// ZJaDe: systemVersion
    class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    /// ZJaDe: systemFloatVersion
    class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }

    /// ZJaDe: deviceName
    class func deviceName() -> String {
        return UIDevice.current.name
    }

    /// ZJaDe: deviceLanguage
    class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }

    /// ZJaDe: deviceModelReadable
    class func deviceModelReadable() -> String {
        return DeviceList[deviceModel()] ?? deviceModel()
    }

    /// ZJaDe: isPhone
    class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    /// ZJaDe: isPad
    class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }

    /// ZJaDe: deviceModel
    class func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machine = systemInfo.machine
        var identifier = ""
        let mirror = Mirror(reflecting: machine)

        for child in mirror.children {
            let value = child.value

            if let value = value as? Int8 , value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }

        return identifier
    }

    // MARK: - Device Version Checks

    enum Versions: Float {
        case five = 5.0
        case six = 6.0
        case seven = 7.0
        case eight = 8.0
        case nine = 9.0
    }

    class func isVersion(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue && systemFloatVersion() < (version.rawValue + 1.0)
    }

    class func isVersionOrLater(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue
    }

    class func isVersionOrEarlier(_ version: Versions) -> Bool {
        return systemFloatVersion() < (version.rawValue + 1.0)
    }

    class var CURRENT_VERSION: String {
        return "\(systemFloatVersion())"
    }

    // MARK: iOS 5 Checks

    class func IS_OS_5() -> Bool {
        return isVersion(.five)
    }

    class func IS_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.five)
    }

    class func IS_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.five)
    }

    // MARK: iOS 6 Checks

    class func IS_OS_6() -> Bool {
        return isVersion(.six)
    }

    class func IS_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.six)
    }

    class func IS_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.six)
    }

    // MARK: iOS 7 Checks

    class func IS_OS_7() -> Bool {
        return isVersion(.seven)
    }

    class func IS_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.seven)
    }

    class func IS_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.seven)
    }

    // MARK: iOS 8 Checks

    class func IS_OS_8() -> Bool {
        return isVersion(.eight)
    }

    class func IS_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.eight)
    }

    class func IS_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.eight)
    }

    // MARK: iOS 9 Checks

    class func IS_OS_9() -> Bool {
        return isVersion(.nine)
    }

    class func IS_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.nine)
    }

    class func IS_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.nine)
    }
}
