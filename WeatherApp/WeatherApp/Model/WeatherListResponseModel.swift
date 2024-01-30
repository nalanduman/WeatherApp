//
//  WeatherListResponseModel.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import Foundation

// MARK: - Welcome
struct WeatherList: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
    
    var dailyList: [List] {
        guard let list = list else { return [] }
        var newList: [List] = []
        for index in stride(from: 0, to: list.count, by: 8) {
            newList.append(list[index])
        }
        return newList
    }
}

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: CoordData?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

// MARK: - Coord
struct CoordData: Codable {
    let lat, lon: Double?
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let clouds: CloudsData?
    let wind: WindData?
    let visibility: Int?
    let pop: Double?
    let sys: SysData?
    let dtTxt: String?
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
    
    var formattedDate: String {
        guard let dt = dt else { return "" }
        return dt.getDate
    }
    
    var formattedDay: String {
        guard let dt = dt else { return "" }
        return dt.getDay
    }
    
    var formattedTime: String {
        guard let dt = dt else { return "" }
        return dt.getTime
    }
}

// MARK: - Clouds
struct CloudsData: Codable {
    let all: Int?
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    var fahrenheitString: String {
        guard let temp = temp else { return "" }
        return String(format: "%.1f", temp)
    }
    
    var celsiusString: String {
        guard let temp = temp else { return "" }
        let celsius = (temp - 32) * 5/9
        return String(format: "%.1f", celsius)
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct SysData: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Wind
struct WindData: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
