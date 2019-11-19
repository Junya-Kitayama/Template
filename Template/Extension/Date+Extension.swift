import Foundation

extension Date {

    func toString(formatType: DateformatType) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatType.rawValue
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: self)
    }
}

extension NSDate {

    func toString(formatType: DateformatType) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatType.rawValue
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: self as Date)
    }
}
