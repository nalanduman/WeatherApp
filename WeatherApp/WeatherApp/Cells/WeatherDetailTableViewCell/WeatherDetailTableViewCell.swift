//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import UIKit

enum Unit: String {
    case fahrenheit = "F"
    case celcius = "C"
}

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var speedLabel: UILabel!
    @IBOutlet weak private var humidityLabel: UILabel!
    
    private var temperatureUnit: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data: WeatherDetailModel?) {
        guard let data = data else { return }
        dateLabel.text = data.date
        temperatureLabel.text = "\(data.temperature ?? "")°\(temperatureUnit ?? "")"
        speedLabel.text = data.speed
        humidityLabel.text = data.humidity
    }
    
    func configureUnit(unit: Unit?, defaultUnit: String) {
        switch unit {
        case .fahrenheit:
            temperatureUnit = "F"
        case .celcius:
            temperatureUnit = "C"
        default:
            temperatureUnit = defaultUnit
        }
    }
}
