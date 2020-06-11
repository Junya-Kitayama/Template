import Foundation

extension Collection {

    /// Out of Rangeのチェック
    subscript(safe index: Index) -> Element? {
        startIndex <= index && index < endIndex ? self[index] : nil
    }

// usage
//    let array = [0, 1, 2]
//    if let item = array[safe: 5] {
//        print("unreachable")
//    }
}

extension Collection where Element: Hashable {
    /// 重複した値を取り除く
    func unified() -> [Element] {
        reduce(into: []) {
            if !$0.contains($1) {
                $0.append($1)
            }
        }
    }
}
