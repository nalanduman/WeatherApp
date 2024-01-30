//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak private var dayLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var unitLabel: UILabel!
    @IBOutlet weak private var conditionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data: List?, selectedSegmentIndex: Int) {
        guard let data = data else { return }
        dayLabel.text = data.formattedDay
        temperatureLabel.text = selectedSegmentIndex == 0 ? data.main?.fahrenheitString : data.main?.celsiusString
        unitLabel.text = selectedSegmentIndex == 0 ? "F" : "C"
        conditionImageView.image = UIImage(systemName: data.weather?.first?.conditionName ?? "")
    }
    
}
