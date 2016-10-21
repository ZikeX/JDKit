
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

    /// ZJaDe: Converts integer value to Double.
    var toDouble: Double { return Double(self) }

    /// ZJaDe: Converts integer value to Float.
    var toFloat: Float { return Float(self) }

    /// ZJaDe: Converts integer value to CGFloat.
    var toCGFloat: CGFloat { return CGFloat(self) }

    /// ZJaDe: Converts integer value to String.
    var toString: String { return String(self) }

    /// ZJaDe: Converts integer value to UInt.
    var toUInt: UInt { return UInt(self) }

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

}

extension UInt {
    /// ZJaDe: Convert UInt to Int
    var toInt: Int { return Int(self) }
}
