//
//  WeatherDetailTableViewCell.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {

    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var speedLabel: UILabel!
    @IBOutlet weak private var humidityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data: WeatherDetailModel?) {
        guard let data = data else { return }
        dateLabel.text = data.date
        temperatureLabel.text = "\(data.temperature ?? "")°\(data.unit ?? "")"
        speedLabel.text = data.speed
        humidityLabel.text = data.humidity
    }
}
