import Foundation

enum MimeType: String {
    case textPlain = "text/plain"
    case multipartFormdata = "multipart/form-data"
    // 適宜追加する
}

struct MultipartFormdata {
    
    static func createMultipartFormDataRequest(fileData: Data,
                                               fileName: String,
                                               mime: MimeType,
                                               name: String, // サーバー側と合わせる
                                               url: URL,
                                               method: HTTPMethod,
                                               headerValue: String,
                                               headerField: String,
                                               boundary: String) -> URLRequest {
        
        let boundaryText = "--\(boundary)\r\n"
        
        var httpBody = Data()
        httpBody.append(boundaryText.data(using: .utf8) ?? Data())
        httpBody.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8) ?? Data())
        httpBody.append("Content-Type: \(mime.rawValue)\r\n\r\n".data(using: .utf8) ?? Data())
        httpBody.append(fileData)
        httpBody.append("\r\n".data(using: .utf8) ?? Data())
        httpBody.append(boundaryText.data(using: .utf8) ?? Data())
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(headerValue, forHTTPHeaderField: headerField)
        urlRequest.httpBody = httpBody
        return urlRequest
    }
}
