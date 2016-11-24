

import Foundation

class SwiftTimer {
    
    private let internalTimer: DispatchSourceTimer
    private var isRunning = false
    
    init(interval: DispatchTimeInterval, repeats: Bool = true, queue: DispatchQueue = .main , handler:(()->())? = nil) {
        internalTimer = DispatchSource.makeTimerSource(queue: queue)
        internalTimer.setEventHandler(handler: handler)
        if repeats {
            internalTimer.scheduleRepeating(deadline: .now() + interval, interval: interval)
        } else {
            internalTimer.scheduleOneshot(deadline: .now() + interval)
        }
    }
    
    func start() {
        if !isRunning {
            internalTimer.resume()
            isRunning = true
        }
    }
    func stop() {
        if isRunning {
            internalTimer.suspend()
            isRunning = false
        }
    }
}
extension SwiftTimer {
    /// ZJaDe: 延时调用
    static func asyncAfter(seconds: Double, queue: DispatchQueue = .main, after: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}