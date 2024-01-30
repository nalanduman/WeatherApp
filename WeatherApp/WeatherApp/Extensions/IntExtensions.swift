//
//  IntExtensions.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import Foundation

extension Int {
    var getDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    var getTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var getDay: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let inputDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        if today == inputDate {
            return "Today"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_EN")
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
    }
    
    func toString() -> String {
        return String(self)
    }
}
