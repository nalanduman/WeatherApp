//
//  DataRequest.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

struct DataRequest: DataRequestProtocol {
    
    var urlString: String
    var method: HTTPMethod = .get
    var path: ApiPath
    var headers: HeaderParameters = [:]
    var params: Parameters?
    var httpBody: Data?
    
    init(host: ApiHost, path: ApiPath) {
        self.urlString = host.rawValue
        self.path = path
    }
    
    func getUrlRequest(with endpoint: String) -> URLRequest {
        var request = URLRequest(url: getUrl(with: endpoint))
        request.httpMethod = method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 60
        request.allHTTPHeaderFields = headers
        request.httpBody = httpBody
        return request
    }
    
    private func getUrl(with endpoint: String) -> URL {
        var components = URLComponents(string: getUrlString(with: endpoint))
        components?.queryItems = getParams()
        return components?.url ?? URL(string: urlString)!
    }
    
    private func getUrlString(with endpoint: String) -> String {
        var apiUrl = "\(endpoint)"
        if path != .none {
            apiUrl = "\(path.rawValue)/\(apiUrl)"
        }
        return "\(urlString)/\(apiUrl)"
    }
    
    private func getParams() -> [URLQueryItem]? {
        if let params = params, method == .get {
            var parameterList: [URLQueryItem] = []
            for param in params {
                parameterList.append(URLQueryItem(name: param.key, value: unwrap(value: param.value)))
            }
            return parameterList.count > 0 ? parameterList : nil
        }
        return nil
    }
    
    private func unwrap(value: Any) -> String {
        let mirror = Mirror(reflecting: value)
        if mirror.displayStyle != .optional {
            return String(describing: value)
        }
        
        if let some = mirror.children.first?.value {
            return String(describing: some)
        }
        return String()
    }
}
