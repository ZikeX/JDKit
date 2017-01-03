
import UIKit

extension String {
    var md5String:String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen);
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.deinitialize();
        
        return String(format: hash as String)
    }
}
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
    private func isValidate(by regex:String) -> Bool {
        let pre = NSPredicate(format: "SELF MATCHES %@", regex)
        return pre.evaluate(with: self)
    }
    /// ZJaDe: 是否全是数字
    var isPureInt:Bool {
        let scan = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val)
    }
    /// ZJaDe: 是否手机号
    var isMobile:Bool {
        return self.length == 11 && self.hasPrefix("1") && self.isPureInt
    }
    /// ZJaDe: 是否全是小写字母
    var isLowercase:Bool {
        let regex = "^[a-z]+$"
        return self.isValidate(by: regex)
    }
    /// ZJaDe: 是否全是大写字母
    var isCapitalized:Bool {
        let regex = "^[A-Z]+$"
        return self.isValidate(by: regex)
    }
    /// ZJaDe: 是否是价格
    var isPrice:Bool {
        let regex = "^\\d*\\.?\\d{0,2}$"
        return self.isValidate(by: regex)
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
