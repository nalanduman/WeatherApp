//
//  HomeBuilder.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation
import UIKit

final class HomeBuilder {
    static func make() -> HomeViewController {
        let view = UIStoryboard.instantiateViewController(.home, HomeViewController.self)
        view.viewModel = HomeViewModel(service: app.weatherService)
        return view
    }
}
