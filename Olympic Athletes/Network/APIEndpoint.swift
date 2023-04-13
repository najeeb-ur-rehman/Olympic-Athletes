//
//  APIEndpoint.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

struct APIEndpoint<T: Encodable>: NetworkRequestProvider {
    var url: URL
    var method: HTTPMethod
    var path: String
    var query: [String: String]?
    var body: T?
    var headers: [String: String]
    var requestType: RequestType
    
    init(url: URL, method: HTTPMethod, path: String, query: [String : String]? = nil, body: T? = nil, headers: [String : String] = [:], requestType: RequestType = .json) {
        self.url = url
        self.method = method
        self.path = path
        self.query = query
        self.body = body
        self.headers = headers
        self.requestType = requestType
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: constructURL())

        urlRequest.httpMethod = method.rawValue

        for (key, value) in requestType.requestHeaders {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = body {
            do {
                let encoder = JSONEncoder()
                encoder.dateEncodingStrategy = .millisecondsSince1970
                urlRequest.httpBody = try encoder.encode(parameters)
            } catch {
                throw error
            }
        }
        
        return urlRequest
    }
    
    private func constructURL() -> URL {
        var url = url.appendingPathComponent(path)
        
        if let query = query {
            var components = URLComponents(string: url.absoluteString)!
            var queryItems = [URLQueryItem]()
            for (key, value) in query {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
            components.queryItems = queryItems
            url = components.url!
        }
        return url
    }
    
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RequestType: Int {
    case json
    case formData
}

extension RequestType {
    var requestHeaders: [String: String] {
        var headers = [String: String]()
        headers["Accept"] = "application/json"
        switch self {
        case .json:
            headers["Content-Type"] = "application/json"
            
        case .formData:
            headers["Content-type"] = "multipart/form-data"
        }
        return headers
    }
}

protocol NetworkRequestProvider {

    func asURLRequest() throws -> URLRequest

}

extension NetworkRequestProvider {
    
    public var urlRequest: URLRequest? { try? asURLRequest() }
    
}
