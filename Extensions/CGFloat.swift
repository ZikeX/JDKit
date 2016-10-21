

import UIKit

extension CGFloat {
    /// ZJaDe: 根据Self返回一个弧度
    func toRadians() -> CGFloat {
        return (CGFloat (M_PI) * self) / 180.0
    }

    /// ZJaDe: 根据Self返回一个弧度
    func degreesToRadians() -> CGFloat {
        return toRadians()
    }

    /// ZJaDe: 把本身，从角度转换成弧度
    mutating func toRadiansInPlace() {
        self = (CGFloat (M_PI) * self) / 180.0
    }

    /// ZJaDe: 根据angle返回一个弧度
    func degreesToRadians (_ angle: CGFloat) -> CGFloat {
        return (CGFloat (M_PI) * angle) / 180.0
    }
}
