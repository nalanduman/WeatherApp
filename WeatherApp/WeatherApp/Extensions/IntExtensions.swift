//
//  IntExtensions.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import Foundation

extension Int {
    var date: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    var getDay: String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let today = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let inputDate = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        if today == inputDate {
            return "Bugün"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "tr_TR")
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: date)
        }
    }
}
