//
//  Timer.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/5.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

typealias TimerExecuteClosure = (Timer?)->()

extension Timer {
    class func timer(_ timeInterval:TimeInterval,repeats:Bool = true,_ closure:@escaping TimerExecuteClosure) -> Timer {
        let seconds:CFAbsoluteTime = max(timeInterval,0.0001)
        let interval:CFAbsoluteTime = repeats ? seconds : 0
        let fireDate:CFAbsoluteTime = CFAbsoluteTimeGetCurrent() + seconds
        let timer = CFRunLoopTimerCreateWithHandler(nil, fireDate, interval, 0, 0,  closure)
        return timer!
    }
    class func scheduleTimer(_ timeInterval:TimeInterval,repeats:Bool = true,_ closure:@escaping TimerExecuteClosure) -> Timer {
        let timer = Timer.timer(timeInterval, repeats: repeats, closure)
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        return timer
    }
}
