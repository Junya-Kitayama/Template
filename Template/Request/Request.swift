import Foundation

protocol Request {

    associatedtype Response: Codable

    var baseURL: URL { get }
    var path: String { get }
    var params: Any? { get }
    var method: HTTPMethod { get }
}

extension Request {

    #if RELEASE
    var baseURL: URL { return URL(string: "https://XXX")! }
    #else
    var baseURL: URL { return URL(string: "https://XXX")! }
    #endif

    func buildURLRequest() -> URLRequest {
        var request = URLRequest(url: baseURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        request.httpMethod = method.rawValue
//        request.setValue( "Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { abort() }
        guard let dic = params as? [String: Any] else { return request }

        let queryItems = dic.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        components.queryItems = queryItems

        switch method {
        case .get:
            request.url = components.url
        case .post:
            if let query = components.query,
                let body = query.data(using: .utf8) {
                request.httpBody = body
            }
        case .put, .patch, .delete:
            break
        }
        return request
    }

    func response(from data: Data?, urlResponse: HTTPURLResponse) -> Result<Response, Error> {
        if let data = data {
            do {
                let json = try JSONDecoder().decode(Response.self, from: data)
                return .success(json)
            } catch {
                return .failure(APIClientError.responseParse(error.localizedDescription) )
            }
        }
        return .failure(APIClientError.missingData)
    }
}
