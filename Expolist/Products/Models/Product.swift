//
//  Product.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation


struct Product: Codable {
    var id: Int
    var title: String
    var category: String
    var description: String
    var quantity: String
    var expiration: Date
    var price: Double
}
