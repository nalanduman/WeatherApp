//
//  AppContainer.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

let app = AppContainer()

final class AppContainer {
    let router = AppRouter()
    let weatherService = WeatherDataService()
}
