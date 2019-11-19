import Foundation

extension String {

    func toDate(format: DateformatType) -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter.date(from: self)
    }

}
