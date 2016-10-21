

extension Bool {
    /// ZJaDe: Bool转换成Int
    var toInt: Int { return self ? 1 : 0}

    /// ZJaDe: Bool取反
    mutating func toggle() -> Bool {
        self = !self
        return self
    }
}
