//
//  Reusable.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation
import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
    static var nibName: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: String(describing: self), bundle: nil ) }
    static var nibName: String {return String(describing: self)  }
}
