//
//  Timer.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/5.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

typealias TimerExecuteClosure = (Timer?)->()

extension Timer {
    @discardableResult
    class func timer(_ timeInterval:TimeInterval,repeats:Bool = true,_ closure:@escaping TimerExecuteClosure) -> Timer {
        let seconds:TimeInterval = max(timeInterval,0.0001)
        let interval:CFAbsoluteTime = repeats ? seconds : 0
        let fireDate:CFAbsoluteTime = CFAbsoluteTimeGetCurrent() + seconds
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0,  closure)
        return timer!
    }
    @discardableResult
    class func scheduleTimer(_ timeInterval:TimeInterval,repeats:Bool = true,_ closure:@escaping TimerExecuteClosure) -> Timer {
        let timer = Timer.timer(timeInterval, repeats: repeats, closure)
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        return timer
    }
}
extension CFRunLoopObserver {
    /// RunLoop beforeWaiting时调用
    ///
    /// - Parameter closure: 返回是否需要注销
    @discardableResult
    static func runWhenBeforeWaiting(closure:@escaping (()->(Bool))) -> CFRunLoopObserver? {
        let runLoop = CFRunLoopGetCurrent()
        let runLoopMode = CFRunLoopMode.defaultMode
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue, true, 0) { (observer, activity) in
            if closure() {
                CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
                return
            }
        }
        CFRunLoopAddObserver(runLoop, observer, runLoopMode)
        return observer
    }
    static func removeRunLoopObserver(observer:CFRunLoopObserver?) {
        if observer != nil {
            let runLoop = CFRunLoopGetCurrent()
            let runLoopMode = CFRunLoopMode.defaultMode
            CFRunLoopRemoveObserver(runLoop, observer, runLoopMode)
        }
    }
}
