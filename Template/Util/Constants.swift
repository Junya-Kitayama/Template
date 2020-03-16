/* アラート */

enum AlertTitle {
    case some

    func getMessage() -> String {
        switch self {
        case .some:
            return ""
        }
    }
}

enum AlertMessage {
    case some

    func getMessage() -> String {
        switch self {
        case .some:
            return ""
        }
    }
}

enum AlertButtonTitle: String {
    case ok = "OK"
    case retry = "再取得"
    case cancel = "キャンセル"
}
