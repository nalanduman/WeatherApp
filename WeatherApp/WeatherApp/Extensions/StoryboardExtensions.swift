//
//  StoryboardExtensions.swift
//  WeatherApp
//
//  Created by Nalan Duman on 29.01.2024.
//

import UIKit

extension UIStoryboard {
    class func instantiateViewController<T: UIViewController>(_ storyboardName: StoryboardName, _: T.Type) -> T {
        guard let viewController = UIStoryboard(name: storyboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Cannot be instantiated")
        }
        
        return viewController
    }
}
