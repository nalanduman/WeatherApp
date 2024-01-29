//
//  NetworkError.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

enum NetworkError: Error {
    case requestFailed
    case invalidData
    case responseUnsuccessful
    case jsonConversionFailure
    case invalidURL
    
    var description: String {
        switch self {
        case .requestFailed:
            return "⁉️⁉️⁉️ NetworkError.requestFailed ⁉️⁉️⁉️"
        case .invalidData:
            return "⭕️⭕️⭕️ NetworkError.invalidData ⭕️⭕️⭕️"
        case .responseUnsuccessful:
            return "💔💔💔 NetworkError.responseUnsuccessful 💔💔💔"
        case .jsonConversionFailure:
            return "🚫🚫🚫 NetworkError.jsonConversionFailure 🚫🚫🚫"
        case .invalidURL:
            return "💢💢💢 NetworkError.invalidURL 💢💢💢"
        }
    }
}
