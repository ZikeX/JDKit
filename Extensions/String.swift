
import UIKit

extension String {
    /// ZJaDe: 根据下标返回字符
    subscript(integerIndex: Int) -> Character {
        let index = characters.index(startIndex, offsetBy: integerIndex)
        return self[index]
    }

    /// ZJaDe: 根据Range返回子字符串
    subscript(integerRange: Range<Int>) -> String {
        let start = characters.index(startIndex, offsetBy: integerRange.lowerBound)
        let end = characters.index(startIndex, offsetBy: integerRange.upperBound)
        let range = start..<end
        return self[range]
    }

    /// ZJaDe:字符串长度
    var length: Int {
        return self.characters.count
    }

    /// ZJaDe: substring的个数
    func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }

    /// ZJaDe: 首字母大写
    var capitalizeFirst: String {
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }

    /// ZJaDe: 是否只有空格和转行符
    func isOnlyEmptySpacesAndNewLineCharacters() -> Bool {
        let characterSet = CharacterSet.whitespacesAndNewlines
        let newText = self.trimmingCharacters(in: characterSet)
        return newText.isEmpty
    }

    /// ZJaDe: 去除空格和转行符
    mutating func trim() {
         self = self.trimmed
    }

    /// ZJaDe: 返回一个去除空格和转行符的字符串
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    /// ZJaDe: 返回char第一次出现的下标
    func getIndexOf(_ char: Character) -> Int? {
        for (index, c) in characters.enumerated() {
            if c == char {
                return index
            }
        }
        return nil
    }
}
extension String {
    /// ZJaDe: 根据CompareOptions，判断是否包含某个字符串
    func contains(_ find: String, compareOption: NSString.CompareOptions = []) -> Bool {
        return self.range(of: find, options: compareOption) != nil
    }
    
    var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    var isNumber: Bool {
        if let _ = NumberFormatter().number(from: self) {
            return true
        }
        return false
    }
    /// ZJaDe: 是否包含 Emoji
    var includesEmoji: Bool {
        for i in 0...length {
            let c: unichar = (self as NSString).character(at: i)
            if (0xD800 <= c && c <= 0xDBFF) || (0xDC00 <= c && c <= 0xDFFF) {
                return true
            }
        }
        return false
    }
}

extension String {
    /// ZJaDe: 提取所有URl
    var extractURLs: [URL] {
        var urls: [URL] = []
        let detector: NSDataDetector?
        do {
            detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        } catch _ as NSError {
            detector = nil
        }
        
        let text = self
        
        if let detector = detector {
            detector.enumerateMatches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count), using: {
                (result: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result, let url = result.url {
                    urls.append(url)
                }
            })
        }
        return urls
    }
}
