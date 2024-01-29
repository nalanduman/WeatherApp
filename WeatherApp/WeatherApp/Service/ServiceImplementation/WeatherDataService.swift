//
//  WeatherDataService.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

class WeatherDataService: BaseService, WeatherDataServiceProtocol {
    
    override init() {
        super.init()
    }
    
    func getWeatherData(params: Parameters, completion: @escaping CallbackResponse<WeatherData>) {
        var dataRequest = DataRequest(host: ApiHost.production, path: .master)
        dataRequest.method = .get
        var parameters: Parameters = params
        parameters[Constants.ParameterKeys.appID] = appID
        parameters[Constants.ParameterKeys.units] = "imperial"
        dataRequest.params = parameters
        
        networking.request(with: dataRequest.getUrlRequest(with: ApiEndpoint.weather.rawValue), showLogs: true) { (result: Result<WeatherData>) in
            switch result {
            case .success(let response):
                completion(response)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
