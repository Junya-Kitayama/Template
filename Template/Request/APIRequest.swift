import Foundation

enum APIRequest {

    struct Something: Request {

        typealias Response = SomeResponse

        var method: HTTPMethod { .post }
        var path: String { "" }
        var params: Any? { nil }
    }
}

class SomeResponse: Codable {}
