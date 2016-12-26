//
//  TaskCenter.swift
//  ZiWoYou
//
//  Created by Z_JaDe on 2016/12/26.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation

class TaskCenter {
    class Task {
        fileprivate var isComplete:Bool = false
        func end() {
            self.isComplete = true
        }
    }
    enum TaskState {
        case state_空闲状态
        case state_执行中
    }
    typealias TaskClosureType = (Task)->()
    private var taskState:TaskState = .state_空闲状态
    private var taskArrray = [TaskClosureType]()
    private(set) var isStop:Bool = false
    private var timer:Timer?
    func addTask(_ closure:@escaping TaskClosureType) {
        taskArrray.append(closure)
        performTask()
    }
    func start() {
        isStop = false
        performTask()
    }
    func stop() {
        isStop = true
    }
    func clear() {
        isStop = true
        taskArrray.removeAll()
        taskState = .state_空闲状态
        timer?.invalidate()
        timer = nil
    }
    // MARK: -
    private func performTask() {
        guard isStop == false else {
            return
        }
        switch taskState {
        case .state_执行中:
            break
        case .state_空闲状态:
            if taskArrray.count > 0 {
                taskState = .state_执行中
                let task = Task()
                taskArrray.removeFirst()(task)
                timer?.invalidate()
                timer = Timer.scheduleTimer(0, { (timer) in
                    if task.isComplete {
                        timer?.invalidate()
                        self.taskState = .state_空闲状态
                        self.performTask()
                    }
                })
            }
        }
    }
}
