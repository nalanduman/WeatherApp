//
//  AppRouter.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import Foundation
import UIKit

final class AppRouter {
    
    let window: UIWindow
        
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start(with windowScene: UIWindowScene) {
        let home = HomeBuilder.make()
        window.rootViewController = home
        window.makeKeyAndVisible()
        window.windowScene = windowScene
    }
}
