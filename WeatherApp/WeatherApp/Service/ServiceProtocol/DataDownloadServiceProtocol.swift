//
//  DataDownloadServiceProtocol.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation

protocol DataDownloadServiceProtocol {
    func downloadData(from urlString: String, completion: @escaping CallbackResponse<Data>)
}
