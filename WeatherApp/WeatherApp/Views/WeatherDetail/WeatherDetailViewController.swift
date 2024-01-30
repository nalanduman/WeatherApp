//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import UIKit

class WeatherDetailViewController: BaseViewController {

    @IBOutlet weak private var cityLabel: UILabel!
    @IBOutlet weak private var dayLabel: UILabel!
    @IBOutlet weak private var detailTableView: UITableView!
    
    var list: [List]?
    var weatherList: WeatherList?
    var selectedUnit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        configureTableView()
        configure()
    }
    
    private func configureTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        registerTableViewNibs()
    }
        
    private func registerTableViewNibs() {
        detailTableView.registerNib(WeatherDetailTableViewCell.self)
        detailTableView.registerNib(WeatherDetailHeaderView.self)
    }
        
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }
    
    private func configure() {
        guard let weatherList = weatherList, let list = list else { return }
        cityLabel.text = weatherList.city?.name
        dayLabel.text = "\(list.first?.formattedDate ?? "") (\(list.first?.formattedDay ?? ""))"
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(WeatherDetailTableViewCell.self, for: indexPath)
        let selectedList = list?[indexPath.row]
        let data: WeatherDetailModel = .init(date: selectedList?.formattedTime, temperature: selectedUnit == 0 ? selectedList?.main?.fahrenheitString : selectedList?.main?.celsiusString, speed: selectedList?.wind?.speed?.toString(), humidity: selectedList?.main?.humidity?.toString(), unit: selectedUnit == 0 ? "F" : "C")
        cell.configure(data)
        return cell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeue(WeatherDetailHeaderView.self)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
