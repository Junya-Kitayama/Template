import Foundation

extension String {

    func toDate(format: DateformatType) -> Date? {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        return dateFormatter.date(from: self)
    }
    
    var localized: String {
        NSLocalizedString(self, comment: self)
    }

    func localized(withTableName tableName: String? = nil,
                   bundle: Bundle = Bundle.main,
                   value: String = "") -> String {
        
        NSLocalizedString(self,
                          tableName: tableName,
                          bundle: bundle,
                          value: value,
                          comment: self)
    }

}
