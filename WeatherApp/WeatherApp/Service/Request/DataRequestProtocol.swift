//
//  DataRequestProtocol.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

protocol DataRequestProtocol {
    var urlString: String { get }
    var method: HTTPMethod { get }
    var headers: HeaderParameters { get }
    var params: Parameters? { get }
    var httpBody: Data? { get }
}
