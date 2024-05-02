//
//  ProductService.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation

class ProductService: ExpolistService {
    
    func getExpired() -> [Product]? {
        guard let allProducts: [Product] = loadBundledContent(fromFileNamed: "Products") else {
            return nil
        }
        
        let now = Date()
        return allProducts.filter { product in
            return product.expiration <= now
        }
    }
    
    
   
}
