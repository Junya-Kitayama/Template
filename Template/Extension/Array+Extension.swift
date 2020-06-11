import Foundation

extension Array where Element: Equatable {
    
    /// 配列からelementの値を取り除く
    /// - Parameter element: 取り除く値
    @discardableResult
    mutating func remove(element: Element) -> Index? {
        guard let index = firstIndex(of: element) else { return nil }
        remove(at: index)
        return index
    }
    
    /// 多重配列から配列を取り除く
    /// - Parameter element: 取り除く配列
    @discardableResult
    mutating func remove(elements: [Element]) -> [Index] {
        elements.compactMap { remove(element: $0) }
    }
}

extension Array where Element: Hashable {
    /// 重複した値を取り除く
    mutating func unify() {
        self = unified()
    }
}
