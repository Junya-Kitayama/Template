/* アラート */
enum Alert {
    
    enum Title {
        case some
    }

    enum Message {
        case some
    }

    enum ButtonTitle: String {
        case ok = "OK"
        case retry = "再取得"
        case cancel = "キャンセル"
    }
}

extension Alert.Title {
    var message: String {
        switch self {
        case .some: return ""
        }
    }
}

extension Alert.Message {
    var message: String {
        switch self {
        case .some: return ""
        }
    }
}
