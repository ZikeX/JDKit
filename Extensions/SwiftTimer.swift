
import Foundation

class SwiftTimer {
    
    private let internalTimer: DispatchSourceTimer
    
    private var isRunning = false
    
    let repeats: Bool
    
    typealias SwiftTimerHandler = (SwiftTimer) -> Void
    
    private var handler: SwiftTimerHandler
    
    init(interval: DispatchTimeInterval, repeats: Bool = true, queue: DispatchQueue = .main , handler: @escaping SwiftTimerHandler) {
        
        self.handler = handler
        self.repeats = repeats
        internalTimer = DispatchSource.makeTimerSource(queue: queue)
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        
        if repeats {
            internalTimer.scheduleRepeating(deadline: .now() + interval, interval: interval)
        } else {
            internalTimer.scheduleOneshot(deadline: .now() + interval)
        }
    }
    
    static func repeaticTimer(interval: DispatchTimeInterval, queue: DispatchQueue = .main , handler: @escaping SwiftTimerHandler ) -> SwiftTimer {
        return SwiftTimer(interval: interval, repeats: true, queue: queue, handler: handler)
    }
    
    deinit {
        if !self.isRunning {
            internalTimer.resume()
        }
    }
    
    func fire() {
        if repeats {
            handler(self)
        } else {
            handler(self)
            internalTimer.cancel()
        }
    }
    
    func start() {
        if !isRunning {
            internalTimer.resume()
            isRunning = true
        }
    }
    
    func suspend() {
        if isRunning {
            internalTimer.suspend()
            isRunning = false
        }
    }
    
    func rescheduleRepeating(interval: DispatchTimeInterval) {
        if repeats {
            internalTimer.scheduleRepeating(deadline: .now() + interval, interval: interval)
        }
    }
    
    func rescheduleHandler(handler: @escaping SwiftTimerHandler) {
        self.handler = handler
        internalTimer.setEventHandler { [weak self] in
            if let strongSelf = self {
                handler(strongSelf)
            }
        }
        
    }
}
//MARK: 延时调用
extension SwiftTimer {
    static func asyncAfter(seconds: Double, queue: DispatchQueue = .main, after: @escaping ()->()) {
        let time = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        queue.asyncAfter(deadline: time, execute: after)
    }
}
//MARK: Throttle
extension SwiftTimer {
    
    private static var timers = [String:DispatchSourceTimer]()
    
    static func throttle(interval: DispatchTimeInterval, identifier: String, queue: DispatchQueue = .main , handler: @escaping () -> Void ) {
        
        if let previousTimer = timers[identifier] {
            previousTimer.cancel()
        }
        
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.scheduleOneshot(deadline: .now() + interval)
        timer.setEventHandler {
            handler()
            timer.cancel()
            timers.removeValue(forKey: identifier)
        }
        timer.resume()
        timers[identifier] = timer
    }
}

//MARK: Count Down
class SwiftCountDownTimer {
    
    private let internalTimer: SwiftTimer
    
    private var leftTimes: Int
    
    private let originalTimes: Int
    
    private let handler: (SwiftCountDownTimer, _ leftTimes: Int) -> Void
    
    init(interval: DispatchTimeInterval, times: Int,queue: DispatchQueue = .main , handler:  @escaping (SwiftCountDownTimer, _ leftTimes: Int) -> Void ) {
        
        self.leftTimes = times
        self.originalTimes = times
        self.handler = handler
        self.internalTimer = SwiftTimer.repeaticTimer(interval: interval, queue: queue, handler: { _ in
        })
        self.internalTimer.rescheduleHandler { [weak self]  swiftTimer in
            if let strongSelf = self {
                if strongSelf.leftTimes > 0 {
                    strongSelf.leftTimes = strongSelf.leftTimes - 1
                    strongSelf.handler(strongSelf, strongSelf.leftTimes)
                } else {
                    strongSelf.internalTimer.suspend()
                }
            }
        }
    }
    
    func start() {
        self.internalTimer.start()
    }
    func fire() {
        self.internalTimer.fire()
    }
    
    func suspend() {
        self.internalTimer.suspend()
    }
    
    func reCountDown() {
        self.leftTimes = self.originalTimes
    }
    
}
