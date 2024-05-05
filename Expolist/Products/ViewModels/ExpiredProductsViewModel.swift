//
//  ExpiredProductsViewModel.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation


class ExpiredProductsViewModel {
    
    private let productService = ProductService()
    private var products: [Product]?
    
    var numberOfProducts: Int {
        return products?.count ?? 0
    }
    
    func load() {
        products = productService.getExpired()
    }
    
    func product(at: Int) -> Product? {
        guard let products = self.products else { return nil }
        return products[at]
    }
    
}

