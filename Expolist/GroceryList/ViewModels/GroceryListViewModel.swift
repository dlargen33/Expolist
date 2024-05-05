//
//  GroceryListViewModel.swift
//  Expolist
//
//  Created by Donald Largen on 5/4/24.
//

import Foundation
import Combine

class GroceryListViewModel {
    private var groceryList: GroceryList
    private var groceryService = GroceryService()

    var itemAdded = PassthroughSubject< (), Never>()
    
    var numberOfItems: Int {
        groceryList.items.count
    }
    
    var title: String {
        groceryList.name
    }
    
    init(list: GroceryList) {
        groceryList = list
    }
    
    func item(at index: Int) -> GroceryItem {
        return groceryList.items[index]
    }
    
    func add(item: GroceryItem){
        groceryList.items.append(item)
        groceryService.update(list: groceryList)
        itemAdded.send(())
    }
}
