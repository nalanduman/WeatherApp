//
//  DataDownloadService.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

class DataDownloadService: BaseService, DataDownloadServiceProtocol {
    
    override init() {
        super.init()
    }
    
    func downloadData(from urlString: String, completion: @escaping CallbackResponse<Data>) {
        networking.download(with: urlString) { (result: Result<Data>) in
            switch result {
            case .failure(_):
                completion(nil)
                return
            case .success(let data):
                completion(data)
                return
            }
        }
    }
}
