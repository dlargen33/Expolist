//
//  GroceryService.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import Foundation

class GroceryService: ExpolistService {
    private let fileName = "grocerylists"
    
    func getLists() -> [GroceryList] {
        guard let lists: [GroceryList] = self.loadSavedContent(fromFileNamed: fileName) else {
            return [GroceryList]()
        }
        return lists
    }
    
    func add(list: GroceryList) {
        var lists = self.getLists()
        lists.append(list)
        self.saveContent(content: lists, toFileNamed: fileName)
    }
    
    func update(list: GroceryList){
        var lists = getLists()
        lists.removeAll { groceryList in
            list.id == groceryList.id
        }
        lists.append(list)
        self.saveContent(content: lists, toFileNamed: fileName)
    }
    
    func removeAll() {
        self.removeContent(fileName: fileName)
    }
}
