import Foundation

protocol KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String {
        "\(Self.self).\(key.rawValue)"
    }
}

protocol UserDefaultSettable: KeyNamespaceable {
    associatedtype Key: RawRepresentable
}

extension UserDefaultSettable {

    func set(_ value: Bool, forKey key: Key) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func set(_ value: String, forKey key: Key) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func bool(forKey key: Key) -> Bool {
        UserDefaults.standard.bool(forKey: namespaced(key))
    }

    func string(forKey key: Key) -> String {
        UserDefaults.standard.string(forKey: namespaced(key)) ?? ""
    }

}

extension UserDefaults: UserDefaultSettable {
    enum Key: String {
        case some
    }
}
