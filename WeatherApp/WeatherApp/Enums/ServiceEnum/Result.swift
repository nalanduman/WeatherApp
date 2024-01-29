//
//  Result.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
