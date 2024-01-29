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
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var unitSegmentedControl: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    var weatherData: WeatherData? {
        didSet {
            guard let weatherData = weatherData else { return }
            setView(weatherData)
        }
    }
    
    lazy var viewModel: HomeViewModel = {
        return HomeViewModel(service: app.weatherService)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        searchTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        unitSegmentedControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        initView()
    }
    
    private func initView() {
        viewModel.showWeatherData = { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let response = response {
                    self.weatherData = response
                }
            }
        }
        
        viewModel.showLoading = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading ?? false {
                    self.startAnimate()
                } else {
                    self.stopAnimate()
                }
            }
        }
        
        viewModel.showError = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                print("ERROR")
            }
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    private func setView(_ weather: WeatherData) {
        self.cityLabel.text = weather.name
        self.temperatureLabel.text = unitSegmentedControl.selectedSegmentIndex == 0 ? weather.main?.fahrenheitString : weather.main?.celsiusString
        self.conditionImageView.image = UIImage(systemName: weather.weather?.first?.conditionName ?? "")
    }
    
    @objc func valueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case 0:
            self.unitLabel.text = "F"
            self.temperatureLabel.text = weatherData?.main?.fahrenheitString
            break
        case 1:
            self.unitLabel.text = "C"
            self.temperatureLabel.text = weatherData?.main?.celsiusString
            break
        default:
            break
        }
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
            viewModel.loadWeather(lat: 0, lon: 0, q: city)
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
            viewModel.loadWeather(lat: lat, lon: lon, q: "")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
