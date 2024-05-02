//
//  UITableView+Extensions.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation
import UIKit

public extension UITableView {
    func dequeueReusableCell<T>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }

    func dequeueReusableCell<T>() -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as! T
    }

    func dequeReusableHeaderFooter<T>() -> T where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }

    func registerReusableCell<T>(type: T.Type) where T: Reusable {
        self.register(type.nib, forCellReuseIdentifier: type.reuseIdentifier)
    }

    func registerReusableHeaderFooter<T>(type: T.Type) where T: Reusable {
        self.register(type.nib, forHeaderFooterViewReuseIdentifier: type.reuseIdentifier)
    }

}
