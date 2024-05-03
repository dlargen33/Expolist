//
//  GroceryService.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import Foundation

class GroceryService: ExpolistService {
    func getLists() -> [GroceryList] {
        guard let lists: [GroceryList] = self.loadSavedContent(fromFileNamed: "grocerylists") else { 
            return [GroceryList]()
        }
        return lists
    }
    
    func add(list: GroceryList) {
        var lists = self.getLists()
        lists.append(list)
        self.saveContent(content: lists, toFileNamed: "grocerylists")
    }
}
