//
//  Timer.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/11/5.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import UIKit

public typealias TimerExcuteClosure = @convention(block) ()->()

extension Timer{
    
    public class func jd_scheduledTimerWithTimeInterval(ti:TimeInterval, closure:TimerExcuteClosure, repeats yesOrNo: Bool) -> Timer{
        return self.scheduledTimer(timeInterval: ti, target: self, selector: #selector(excuteTimerClosure(timer:)), userInfo: unsafeBitCast(closure, to: AnyObject.self), repeats: true)
    }
    
    class func excuteTimerClosure(timer: Timer) {
        let closure = unsafeBitCast(timer.userInfo, to: TimerExcuteClosure.self)
        closure()
    }
}
