//
//  WeatherDataServiceProtocol.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

protocol WeatherDataServiceProtocol {
    func getWeatherData(params: Parameters, completion: @escaping CallbackResponse<WeatherData>)
    func getWeatherList(params: Parameters, completion: @escaping CallbackResponse<WeatherList>)
}
