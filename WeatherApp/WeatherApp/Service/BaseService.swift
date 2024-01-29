//
//  BaseService.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

class BaseService {
    
    let networking: NetworkServiceProtocol
    
    init() {
        networking = NetworkService(showAllLogs: true)
    }
}
