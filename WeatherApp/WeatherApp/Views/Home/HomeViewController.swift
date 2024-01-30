//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {

    @IBOutlet weak private var conditionImageView: UIImageView!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var unitLabel: UILabel!
    @IBOutlet weak private var unitSegmentedControl: UISegmentedControl!
    @IBOutlet weak private var weatherListTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var weatherList: WeatherList? {
        didSet {
            guard weatherList != nil else { return }
            reloadTableView()
        }
    }
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
        configureTableView()
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
                self.weatherData = response
                
            }
        }
        
        viewModel.showWeatherList = { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.weatherList = response
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
    
    private func configureTableView() {
        weatherListTableView.delegate = self
        weatherListTableView.dataSource = self
        registerTableViewNibs()
    }
        
    private func registerTableViewNibs() {
        weatherListTableView.registerNib(WeatherTableViewCell.self)
    }
        
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.weatherListTableView.reloadData()
        }
    }
    
    private func setView(_ weather: WeatherData) {
        cityLabel.text = weather.name
        temperatureLabel.text = unitSegmentedControl.selectedSegmentIndex == 0 ? weather.main?.fahrenheitString : weather.main?.celsiusString
        unitLabel.text = unitSegmentedControl.titleForSegment(at: unitSegmentedControl.selectedSegmentIndex)
        conditionImageView.image = UIImage(systemName: weather.weather?.first?.conditionName ?? "")
    }
    
    @objc func valueChanged(_ sender: UISegmentedControl) {
        reloadTableView()
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
            loadWeather(lat: 0, lon: 0, q: city)
        }
        searchTextField.text = ""
    }
    
    func loadWeather(lat: Double? = 0, lon: Double? = 0, q: String? = "") {
        viewModel.loadWeather(lat: lat, lon: lon, q: q)
        viewModel.loadWeatherList(lat: lat, lon: lon, q: q)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            loadWeather(lat: lat, lon: lon, q: "")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "WeatherDetailViewController", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WeatherDetailViewController" {
            if let vc = segue.destination as? WeatherDetailViewController, let selectedIndex = sender as? Int {
                vc.list = weatherList?.list?.filter({ $0.formattedDate == weatherList?.dailyList[selectedIndex].formattedDate }) 
                vc.weatherList = weatherList
                vc.selectedUnit = unitSegmentedControl.selectedSegmentIndex
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList?.dailyList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(WeatherTableViewCell.self, for: indexPath)
        cell.configure(weatherList?.dailyList[indexPath.row], selectedSegmentIndex: unitSegmentedControl.selectedSegmentIndex)
        return cell
    }
}
