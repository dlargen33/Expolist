//
//  CircleMember.swift
//  Expolist
//
//  Created by Donald Largen on 5/5/24.
//

import Foundation

struct CircleMember: Codable {
    var id = UUID()
    var name: String
    var groceryLists = [UUID]()
}
