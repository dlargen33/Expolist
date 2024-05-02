//
//  ExpolistService.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation

protocol ExpolistService {
    func loadBundledContent<Output:Decodable>(fromFileNamed name: String) -> Output?
}

extension ExpolistService {
    func loadBundledContent<Output:Decodable>(fromFileNamed name: String) -> Output? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            return nil
        }

       do {
           let data = try Data(contentsOf: url)
           let decoder = JSONDecoder()
           decoder.dateDecodingStrategy = .formatted(DateFormatter.basic)
           decoder.keyDecodingStrategy = .convertFromSnakeCase
           return try decoder.decode(Output.self, from: data)
       } catch {
           print(error)
           return nil
       }
    }
}
