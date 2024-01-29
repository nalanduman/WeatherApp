//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    let showAllLogs: Bool
    let session: URLSession
    
    init(configuration: URLSessionConfiguration, showAllLogs: Bool) {
        self.session = URLSession(configuration: configuration)
        self.showAllLogs = showAllLogs
    }
    
    convenience init(showAllLogs: Bool) {
        self.init(configuration: .default, showAllLogs: showAllLogs)
    }
    
    func request<T>(with request: URLRequest, showLogs: Bool, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        if self.showAllLogs || showLogs {
            printLogs(for: request)
        }
        
        session.dataTask(with: request) { [weak self] (data, response, err) in
            guard let self = self else { return }
            do {
                let data = try self.handleResponse(data: data, response: response, error: err)
                if self.showAllLogs || showLogs {
                    if let jsonString = data.prettyPrintedJSONString {
                        print("✅ Response ✅")
                        print(jsonString)
                    }
                }
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
                return
            }
            catch {
                if self.showAllLogs || showLogs {
                    if let networkError = error as? NetworkError {
                        print("\(networkError.description) - NetworkService (class) - request (func) - handleResponse (sub func)")
                    } else {
                        print("👻👻👻 \(error.localizedDescription) 👻👻👻 - NetworkService (class) - request (func)")
                    }
                    
                    if let jsonString = data?.prettyPrintedJSONString {
                        print("♦️♦️♦️ Wrong Response ♦️♦️♦️")
                        print(jsonString)
                    }
                }
                completion(.failure(error))
                return
            }
        }.resume()
    }
    
    func download<T>(with urlString: String, completion: @escaping (Result<T>) -> Void) where T : Decodable {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url, timeoutInterval: Double.infinity)
        
        session.dataTask(with: request) { [weak self] (data, response, err) in
            guard let self = self else { return }
            do {
                let data = try self.handleResponse(data: data, response: response, error: err)
                guard let data = data as? T else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                completion(.success(data))
                return
            }
            catch {
                completion(.failure(error))
                return
            }
        }.resume()
    }
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) throws -> Data {
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.requestFailed
        }
        
        guard 200..<300 ~= response.statusCode else {
            print("♨️♨️♨️ statusCode error -> statusCode: (\(response.statusCode)) ♨️♨️♨️")
            throw NetworkError.responseUnsuccessful
        }
        
        guard let data = data else {
            throw NetworkError.invalidData
        }
        
        return data
    }
    
    private func printLogs(for request: URLRequest) {
        if let url = request.url {
            print("👐 URL: \(url.absoluteString)")
        }
        
        if let httpMethod = request.httpMethod {
            print("👍 HTTP Method: \(httpMethod)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            print("👒 Headers 👒")
            print("------------------------------------")
            for item in headers {
                print("- \(item.key) = \(item.value)")
            }
            print("------------------------------------")
        }
        
        if let url = request.url, let components = URLComponents(url: url, resolvingAgainstBaseURL: false), let queryItems = components.queryItems {
            print("🤝 Parameters 🤝")
            print("------------------------------------")
            for item in queryItems {
                if let value = item.value {
                    print("- \(item.name) = \(value)")
                }
            }
            print("------------------------------------")
        }
        
        if let bodyData = request.httpBody,
           let bodyString = bodyData.prettyPrintedJSONString {
            print("👊 Body 👊")
            print("------------------------------------")
            print(bodyString)
            print("------------------------------------")
        }
    }
}
