
import UIKit

extension Int {
    /// ZJaDe: Checks if the integer is even.
    var isEven: Bool { return (self % 2 == 0) }

    /// ZJaDe: Checks if the integer is odd.
    var isOdd: Bool { return (self % 2 != 0) }

    /// ZJaDe: Checks if the integer is positive.
    var isPositive: Bool { return (self > 0) }

    /// ZJaDe: Checks if the integer is negative.
    var isNegative: Bool { return (self < 0) }

    /// ZJaDe: Converts integer value to a 0..<Int range. Useful in for loops.
    var range: CountableRange<Int> { return 0..<self }

    /// ZJaDe: Returns number of digits in the integer.
    var digits: Int {
        if self == 0 {
            return 1
        } else if Int(fabs(Double(self))) <= LONG_MAX {
            return Int(log10(fabs(Double(self)))) + 1
        } else {
            return -1; //out of bound
        }
    }

    /// ZJaDe: 返回随机数
    static func random(min: Int = 0, max: Int = 50) -> Int {
        return Double.random(min: min.toDouble, max: max.toDouble).toInt
    }
}
