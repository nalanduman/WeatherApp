//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

class HomeViewModel {
    
    private let service: WeatherDataServiceProtocol
    
    var showLoading: CallbackResponse<Bool>?
    var showWeatherData: CallbackResponse<WeatherData>?
    var showWeatherList: CallbackResponse<WeatherList>?
    var showError: VoidCallback?
    
    init(service: WeatherDataServiceProtocol) {
        self.service = service
    }
    
    func loadWeather(lat: Double? = 0, lon: Double? = 0, q: String? = "") {
        showLoading?(true)
        
        var params: Parameters = .init()
        params[Constants.ParameterKeys.lat] = lat
        params[Constants.ParameterKeys.lon] = lon
        params[Constants.ParameterKeys.q] = q
        
        service.getWeatherData(params: params) { [weak self] response in
            guard let self = self else { return }
            showLoading?(false)
            if let response = response {
                showWeatherData?(response)
            } else {
                showError?()
            }
        }
    }
    
    func loadWeatherList(lat: Double? = 0, lon: Double? = 0, q: String? = "") {
        showLoading?(true)
        
        var params: Parameters = .init()
        params[Constants.ParameterKeys.lat] = lat
        params[Constants.ParameterKeys.lon] = lon
        params[Constants.ParameterKeys.q] = q
        
        service.getWeatherList(params: params) { [weak self] response in
            guard let self = self else { return }
            showLoading?(false)
            if let response = response {
                showWeatherList?(response)
            } else {
                showError?()
            }
        }
    }
}
