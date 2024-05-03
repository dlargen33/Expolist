//
//  GroceryListViewModel.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import Foundation
import Combine

class GroceryListViewModel {
    
    private var lists = [GroceryList]()
    private var groceryService = GroceryService()
    
    var locationsSubject = PassthroughSubject< (), Never>()
    var numberOfItems: Int {
        return lists.count
    }
    
    func load() {
        lists = groceryService.getLists()
        locationsSubject.send(())
    }
    
    func list(at index: Int) -> GroceryList {
        return lists[index]
    }
}
