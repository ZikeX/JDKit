

import UIKit

class SwiftTimer {
    private let internalTimer: DispatchSourceTimer
    private var isRunning = false
    
    init(interval: DispatchTimeInterval, repeats: Bool = true, queue: DispatchQueue = .main , handler: DispatchSourceProtocol.DispatchSourceHandler?) {
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
