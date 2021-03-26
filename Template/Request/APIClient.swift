import Foundation

enum APIClient {

    static func send<APIRequest: Request>(request: APIRequest,
                                          completion: @escaping (Result<APIRequest.Response, Error>) -> Void) {
        guard let urlRequest = request.buildURLRequest() else {
            return
        }
        
        Logger.debug(urlRequest.url!.absoluteString)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                Logger.error(error.localizedDescription)
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse {
                if case (200..<300) = response.statusCode {} else {
                    Logger.error("status code: \(response.statusCode)")
                    completion(.failure(APIClientError.statusCode(response.statusCode)))
                    return
                }
            }

            let result = request.response(from: data, urlResponse: response as! HTTPURLResponse)
            completion(result)
        }
        task.resume()
    }
}
