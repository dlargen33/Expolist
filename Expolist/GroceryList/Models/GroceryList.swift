//
//  GroceryList.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import Foundation

struct GroceryItem: Codable {
    var id = UUID()
    var name: String
    var quantity: String
}

class GroceryList: Codable {
    var id = UUID()
    var items = [GroceryItem]()
    var createdOn = Date()
    var name: String
    
    init(name: String) {
        self.name = name
        self.items = [GroceryItem]()
        self.createdOn = Date()
    }
    
    func removeAll() {
        items.removeAll()
    }
    
    func add(item: GroceryItem) {
        items.append(item)
    }
}
