

import Foundation

extension FloatingPoint {
    /// ZJaDe: 绝对值
    func abs () -> Self {
        return Foundation.fabs(self)
    }
    /// ZJaDe: 平方根
    func sqrt () -> Self {
        return Foundation.sqrt(self)
    }
    /// ZJaDe: 向下取整
    func floor () -> Self {
        return Foundation.floor(self)
    }
    /// ZJaDe: 向上取整
    func ceil () -> Self {
        return Foundation.ceil(self)
    }
    /// ZJaDe: 四舍五入
    func round () -> Self {
        return Foundation.round(self)
    }
    /// ZJaDe: 根据increment四舍五入
    func roundToNearest(increment: Self) -> Self {
        let remainder = self.truncatingRemainder(dividingBy: increment)
        return remainder < increment / 2 ? self - remainder : self - remainder + increment
    }
    /// ZJaDe: 找到3个数中间的那个
    func clamp(min: Self, _ max: Self) -> Self {
        return Swift.max(min, Swift.min(max, self))
    }
    /// ZJaDe: 返回随机数
    static func random(min: Self = 0, max: Self = 1) -> Self {
        let diff = max - min;
        let rand = Self(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Self(RAND_MAX)) * diff) + min;
    }
}
