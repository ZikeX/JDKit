

import UIKit

extension Timer {
    
    /// ZJaDe: 延时调用
    static func runThisAfterDelay(seconds: Double, queue: DispatchQueue = .main, after: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
    /// ZJaDe: 从某个时间开始，每过一段时间运行一次, 用timer.invalidate()来关闭
    static func runThisEvery(seconds: TimeInterval, startAfterSeconds: TimeInterval = 0, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = startAfterSeconds + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, seconds, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
}
