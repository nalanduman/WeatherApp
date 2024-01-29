//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    let locationManager = CLLocationManager()
    
    var viewModel: HomeViewModelProtocol? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        searchTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            viewModel?.loadWeather(lat: 0, lon: 0, q: city)
        }
        searchTextField.text = ""
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            viewModel?.loadWeather(lat: lat, lon: lon, q: "")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func handleViewModelOutput(output: HomeViewModelOutput) {
        DispatchQueue.main.async {
            switch output {
            case .setLoading(let isLoading):
                if isLoading {
                    self.startAnimate()
                } else {
                    self.stopAnimate()
                }
            case .showWeatherData(let weather):
                self.cityLabel.text = weather.name
                self.temperatureLabel.text = weather.main?.temperatureString
                self.conditionImageView.image = UIImage(systemName: weather.weather?.first?.conditionName ?? "")
            case .error:
                break
            }
        }
    }
}
