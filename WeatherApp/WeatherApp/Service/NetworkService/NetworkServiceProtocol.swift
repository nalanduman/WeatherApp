//
//  NetworkServiceProtocol.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(with request: URLRequest, showLogs: Bool, completion: @escaping (Result<T>) -> Void)
    func download<T: Decodable>(with urlString: String, completion: @escaping (Result<T>) -> Void)
}
