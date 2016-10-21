//
//  Log.swift
//  ZiWoYou
//
//  Created by 茶古电子商务 on 16/9/23.
//  Copyright © 2016年 Z_JaDe. All rights reserved.
//

import Foundation
// MARK: - 在 Relase 模式下，关闭后台打印
func logDebug<T>(_ message: T) {
    #if DEBUG
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "'当前时间:'HH:mm:ss.SSS"
        print("\(timeFormatter.string(from: Date())): \(message)")
    #endif
}
func logInfo<T>(_ message: T) {
    print(message)
}
func logError<T>(_ message: T,file: String = #file,method: String = #function,line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}
