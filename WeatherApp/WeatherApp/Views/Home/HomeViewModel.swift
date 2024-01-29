//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

class HomeViewModel {
    
    private let service: WeatherDataServiceProtocol
    
    var delegate: HomeViewModelDelegate?
    
    init(service: WeatherDataServiceProtocol) {
        self.service = service
    }
    
    private func notify(output: HomeViewModelOutput) {
        delegate?.handleViewModelOutput(output: output)
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func loadWeather(lat: Double? = 0, lon: Double? = 0, q: String? = "") {
        notify(output: .setLoading(true))
        
        var params: Parameters = .init()
        params[Constants.ParameterKeys.lat] = lat
        params[Constants.ParameterKeys.lon] = lon
        params[Constants.ParameterKeys.q] = q
        
        service.getWeatherData(params: params) { [weak self] response in
            guard let self = self else { return }
            notify(output: .setLoading(false))
            if let response = response {
                notify(output: .showWeatherData(response))
            } else {
                notify(output: .error)
            }
        }
    }
}
