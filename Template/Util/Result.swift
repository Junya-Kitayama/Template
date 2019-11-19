import Foundation

// swift5からはResultが標準ライブラリに含まれているので
// 標準のものを使うこと

enum Result<T, Error> {
    case success(T)
    case failure(Error)

    init(value: T) {
        self = .success(value)
    }

    init(error: Error) {
        self = .failure(error)
    }
}
