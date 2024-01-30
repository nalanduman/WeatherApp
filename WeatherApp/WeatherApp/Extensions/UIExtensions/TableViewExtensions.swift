//
//  TableViewExtensions.swift
//  WeatherApp
//
//  Created by Nalan Duman on 30.01.2024.
//

import UIKit

extension UITableView {
    func registerNib<T: UITableViewCell>(_: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UITableViewHeaderFooterView>(_: T.Type) {
        self.register(UINib(nibName: String(describing: T.self), bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: String(describing: T.self))
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as? T else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as? T else { fatalError("Could not deque cell with type \(T.self)") }
        return cell
    }
}
