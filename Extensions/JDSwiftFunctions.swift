
import UIKit
struct jd {
    
}
extension jd {
    /// ZJaDe: 返回命名空间
    static var namespace: String {
        return Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
    }
    /// ZJaDe: 返回app名称
    static var appDisplayName: String? {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else if let bundleName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
            return bundleName
        }
        return nil
    }
    
    /// ZJaDe: 返回app版本号
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    /// ZJaDe: 返回app测试号
    static var appBuild: String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    /// ZJaDe: 返回app版本号+测试号
    static var appVersionAndBuild: String {
        if appVersion == appBuild {
            return "v\(appVersion)"
        } else {
            return "v\(appVersion)(\(appBuild))"
        }
    }
    
    /// ZJaDe: 返回设备版本号
    static var deviceVersion: String {
        var size: Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        return String(cString: machine)
    }
}
extension jd {
    /// ZJaDe: 返回是否DEBUG
    static var isDebug: Bool {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
    
    /// ZJaDe: 返回是否Release
    static var isRelease: Bool {
        #if DEBUG
            return false
        #else
            return true
        #endif
    }
    
    /// ZJaDe: 返回是否是模拟器
    static var isSimulator: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return true
        #else
            return false
        #endif
    }
    
    /// ZJaDe: 是否是真机
    static var isDevice: Bool {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return false
        #else
            return true
        #endif
    }
}
extension jd {
    static var keyWindow:UIWindow {
        return UIApplication.shared.keyWindow!
    }
    static var rootWindow:UIWindow {
        return UIApplication.shared.delegate!.window!!
    }
    /// ZJaDe: 返回最顶端的控制器
    static func visibleVC(_ base: UIViewController? = rootWindow.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return visibleVC(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return visibleVC(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return visibleVC(presented)
        }
        return base
    }
    /// ZJaDe: 返回modal时最上层的控制器
    static var topMostVC: UIViewController? {
        var presentedVC = rootWindow.rootViewController
        while let pVC = presentedVC?.presentedViewController {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            print("EZSwiftExtensions Error: You don't have any views set. You may be calling them in viewDidLoad. Try viewDidAppear instead.")
        }
        return presentedVC
    }
    /// ZJaDe: 返回当前的nav控制器
    static var currentNavC:UINavigationController {
        let currentNavigationController = (jd.appRootVC as! UINavigationController).visibleViewController!.navigationController!
        if currentNavigationController != appRootVC {
            logInfo("当前navC不是根navC")
        }
        return currentNavigationController
    }
    static var appRootVC:UIViewController {
        return rootWindow.rootViewController!
    }
}
extension jd {
    
    #if os(iOS)
    
    /// ZJaDe: 返回屏幕方向
    static var screenOrientation: UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    #endif
    
    /// ZJaDe: horizontalSizeClass
    static var horizontalSizeClass: UIUserInterfaceSizeClass {
        return self.topMostVC?.traitCollection.horizontalSizeClass ?? UIUserInterfaceSizeClass.unspecified
    }
    
    /// ZJaDe: verticalSizeClass
    static var verticalSizeClass: UIUserInterfaceSizeClass {
        return self.topMostVC?.traitCollection.verticalSizeClass ?? UIUserInterfaceSizeClass.unspecified
    }
    
    /// ZJaDe: 返回屏幕scale
    static var screenScale:CGFloat {
        return UIScreen.main.scale
    }
    /// ZJaDe: 根据设备品种和方向，返回屏幕宽度
    static var screenWidth: CGFloat {
        
        #if os(iOS)
            
            if UIInterfaceOrientationIsPortrait(screenOrientation) {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
            
        #elseif os(tvOS)
            
            return UIScreen.mainScreen().bounds.size.width
            
        #endif
    }
    /// ZJaDe: 根据设备品种和方向，返回屏幕高度
    static var screenHeight: CGFloat {
        
        #if os(iOS)
            
            if UIInterfaceOrientationIsPortrait(screenOrientation) {
                return UIScreen.main.bounds.size.height
            } else {
                return UIScreen.main.bounds.size.width
            }
            
        #elseif os(tvOS)
            
            return UIScreen.mainScreen().bounds.size.height
            
        #endif
    }
    
    #if os(iOS)
    
    /// ZJaDe: 返回状态栏的高度
    static var screenStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    /// ZJaDe: 返回状态栏下面的屏幕高度
    static var screenHeightWithoutStatusBar: CGFloat {
        if UIInterfaceOrientationIsPortrait(screenOrientation) {
            return UIScreen.main.bounds.size.height - screenStatusBarHeight
        } else {
            return UIScreen.main.bounds.size.width - screenStatusBarHeight
        }
    }
    
    #endif
}
extension jd {
    /// ZJaDe: 返回国家和地图的代码
    static var currentRegion: String? {
        return (Locale.current as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
    }
    
    /// ZJaDe: 屏幕截图的时候回调
    static func detectScreenShot(_ action: @escaping () -> ()) {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIApplicationUserDidTakeScreenshot, object: nil, queue: mainQueue) { notification in
            // executes after screenshot
            action()
        }
    }
}

