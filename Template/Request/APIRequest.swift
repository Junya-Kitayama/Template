import Foundation

enum APIRequest {

    struct SomeThing: Request {

        typealias Response = SomeResponse

        var method: HTTPMethod { return .post }
        var path: String { return "" }
        var params: Any? { return nil }
    }
}

class SomeResponse: Codable {}
