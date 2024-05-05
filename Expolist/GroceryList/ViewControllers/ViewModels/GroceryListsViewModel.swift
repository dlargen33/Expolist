//
//  GroceryListViewModel.swift
//  Expolist
//
//  Created by Donald Largen on 5/2/24.
//

import Foundation
import Combine

class GroceryListsViewModel {
    
    private var lists = [GroceryList]()
    private var groceryService = GroceryService()
    
    var listsSubject = PassthroughSubject< (), Never>()
    var numberOfItems: Int {
        return lists.count
    }
    
    func load() {
        lists = groceryService.getLists()
        listsSubject.send(())
    }
    
    func list(at index: Int) -> GroceryList {
        return lists[index]
    }
    
    func addList(list: GroceryList) {
        groceryService.add(list: list)
        load()
    }
}
