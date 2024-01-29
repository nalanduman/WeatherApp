//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import UIKit

class BaseViewController: UIViewController {

    let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        activityIndicator.center = self.view.center
        activityIndicator.style = .medium
    }
    
    func startAnimate() {
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func stopAnimate() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}

