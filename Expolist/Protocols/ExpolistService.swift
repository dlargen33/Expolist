//
//  ExpolistService.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import Foundation

protocol ExpolistService {
    func loadBundledContent<Output:Decodable>(fromFileNamed name: String) -> Output?
    func loadSavedContent<Output: Decodable>(fromFileNamed name: String) -> Output?
    func saveContent<Input: Encodable>(content: Input, toFileNamed name:String) -> Bool
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
    
    func loadSavedContent<Output: Decodable>(fromFileNamed name: String) -> Output? {
        do {
            let directoryURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = URL(fileURLWithPath: name,
                              relativeTo: directoryURL)
            
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.basic)
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Output.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
    
    @discardableResult
    func saveContent<Input: Encodable>(content: Input, toFileNamed name:String) -> Bool {
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .formatted(DateFormatter.basic)
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(content)
            let directoryURL = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = URL(fileURLWithPath: name,
                              relativeTo: directoryURL)
            try data.write(to: fileURL)
            return true
        } catch {
            print(error)
            return false
        }
        
    }
}
