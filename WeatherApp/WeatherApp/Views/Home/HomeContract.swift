//
//  HomeContract.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

enum HomeViewModelOutput {
    case setLoading(Bool)
    case showWeatherData(WeatherData)
    case error
}

protocol HomeViewModelProtocol: AnyObject {
    var delegate: HomeViewModelDelegate?{ get set }
    func loadWeather(lat: Double?, lon: Double?, q: String?)
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewModelOutput(output: HomeViewModelOutput)
}
