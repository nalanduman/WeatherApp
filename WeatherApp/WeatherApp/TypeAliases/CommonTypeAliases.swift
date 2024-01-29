//
//  CommonTypeAliases.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

// MARK: - Dictionaries
typealias Parameters = [String: Any]
typealias HeaderParameters = [String : String]

// MARK: - Closures
typealias CallbackResponse<T> = (_ resp: T?) -> Void
