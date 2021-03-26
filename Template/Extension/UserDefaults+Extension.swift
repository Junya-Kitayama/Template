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

extension UserDefaults {
  func setEncoded<T: Encodable>(_ value: T, forKey key: Key) {
    guard let data = try? JSONEncoder().encode(value) else {
        print("Can not Encode to JSON.")
        return
    }
    let key = namespaced(key)
    set(data, forKey: key)
  }

  func decodedObject<T: Decodable>(_ type: T.Type, forKey key: Key) -> T? {
    let key = namespaced(key)
    guard let data = data(forKey: key) else {
        return nil
    }
    return try? JSONDecoder().decode(type, from: data)
  }
}
